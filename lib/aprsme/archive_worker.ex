defmodule Aprsme.ArchiveWorker do
  @archive_queue_name "aprs:archive"
  @source_exchange_name "aprs:messages"

  use GenServer
  require Poison
  require Logger

  alias Aprsme.Repo
  alias Aprsme.Aprs.Packet

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, [], args)
  end

  def init(state \\ []) do
    IO.puts "#{__MODULE__}: init()"
    {:ok, connection} = AMQP.Connection.open(rabbitmq_url())
    {:ok, channel} = AMQP.Channel.open(connection)

    log("Declaring queue #{@archive_queue_name}")
    {:ok, _queue} = AMQP.Queue.declare(channel, @archive_queue_name, durable: true)

    log("Binding #{@archive_queue_name} to source #{@source_exchange_name}")
    :ok = AMQP.Queue.bind(channel, @archive_queue_name, @source_exchange_name, routing_key: "#")

    log("basic.consume...")
    AMQP.Basic.consume(channel, @archive_queue_name, nil, no_ack: true)

    log("Wait_for_messages")

    {:ok, state}
  end

  def handle_info({:basic_deliver, payload, _meta}, state) do
    case Poison.decode(payload) do
      {:ok, packet_params} ->
        packet_params = add_point_to_packet(packet_params)
        changeset = %Packet{} |> Packet.changeset(packet_params)

        case Repo.insert(changeset) do
          {:ok, _} ->
            true

          {:error, changeset} ->
            log("**********")
            log("Could not insert changeset: #{inspect(changeset.errors)}")
            IO.inspect(packet_params)
            log("")
        end

      _ ->
        log("unable to parse JSON, perl sucks")
    end

    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp rabbitmq_url() do
    Application.get_env(:aprsme, :rabbitmq_url)
  end

  defp log(msg) do
    Logger.info(msg)
  end

  # This belongs as a step in the Packet.changeset pipeline
  defp add_point_to_packet(packet_params) do
    case packet_params do
      %{"latitude" => lat, "longitude" => lon} ->
        Map.put(packet_params, "point", make_point(lat, lon))

      _ ->
        packet_params
    end
  end

  defp make_point(lat, lon) do
    %Geo.Point{coordinates: {lon, lat}, srid: 4326}
  end
end
