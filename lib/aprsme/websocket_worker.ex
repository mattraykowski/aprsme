defmodule Aprsme.WebsocketWorker do
  @queue_name "aprs:messages"
  @source_exchange_name "aprs:messages"

  use GenServer
  require Logger

  def start_link(args \\ []) do
    IO.puts("#{__MODULE__}.start_link()")
    GenServer.start_link(__MODULE__, [], name: :websocket_worker)
  end

  def init(state \\ []) do
    Process.send_after(self(), :connect, 5000)
    {:ok, state}
  end

  def handle_info(:connect, state) do
    IO.puts("#{__MODULE__}:: Attempting to connect to RabbitMQ")

    log("rabbitmq_url: #{rabbitmq_url()}")

    log("Connecting...")

    with {:ok, connection} <- AMQP.Connection.open(rabbitmq_url()),
         {:ok, channel} <- AMQP.Channel.open(connection) do
      log("Declaring exchange...")
      AMQP.Exchange.declare(channel, @source_exchange_name, :topic)

      log("Declaring queue #{@queue_name}")
      {:ok, _queue} = AMQP.Queue.declare(channel, @queue_name, durable: false)

      log("Binding #{@queue_name} to source #{@source_exchange_name}")
      :ok = AMQP.Queue.bind(channel, @queue_name, @source_exchange_name, routing_key: "#")

      log("basic.consume...")
      AMQP.Basic.consume(channel, @queue_name, nil, no_ack: true)

      log("#{__MODULE__}: Waiting for messages")

      {:noreply, state}
    end

    # log("Opening channel")
    # {:ok, channel} = AMQP.Channel.open(connection)

    # log("Declaring exchange...")

    # log("Declaring queue #{@queue_name}")
    # {:ok, _queue} = AMQP.Queue.declare(channel, @queue_name, durable: false)

    # log("Binding #{@queue_name} to source #{@source_exchange_name}")
    # :ok = AMQP.Queue.bind(channel, @queue_name, @source_exchange_name, routing_key: "#")

    # log("basic.consume...")
    # AMQP.Basic.consume(channel, @queue_name, nil, no_ack: true)

    # log("waiting for messages")

    # {:ok, state}
  end

  # change to handle_info
  def handle_info({:basic_deliver, payload, _meta}, state) do
    AprsmeWeb.Endpoint.broadcast!("aprs:messages", "aprs:position", %{payload: payload})

    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp rabbitmq_url() do
    Application.get_env(:aprsme, :rabbitmq_url)
  end

  defp log(msg) do
    # IO.puts msg
    Logger.info("[#{Timex.now()}] [#{__MODULE__}] #{msg}")
  end
end
