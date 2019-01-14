defmodule Aprsme.WebsocketWorker do
  @queue_name "aprs:messages"
  @source_exchange_name "aprs:messages"

  use GenServer
  require Logger

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, [], args)
  end

  def init(state \\ []) do
    log("rabbitmq_url: #{rabbitmq_url()}")

    log("Connecting...")
    {:ok, connection} = AMQP.Connection.open(rabbitmq_url())

    log("Opening channel")
    {:ok, channel} = AMQP.Channel.open(connection)

    log("declaring exchange...")
    AMQP.Exchange.declare(channel, @source_exchange_name, :topic)

    log("Declaring queue #{@queue_name}")
    {:ok, _queue} = AMQP.Queue.declare(channel, @queue_name, durable: false)

    log("Binding #{@queue_name} to source #{@source_exchange_name}")
    :ok = AMQP.Queue.bind(channel, @queue_name, @source_exchange_name, routing_key: "#")

    log("basic.consume...")
    AMQP.Basic.consume(channel, @queue_name, nil, no_ack: true)

    log("waiting for messages")

    {:ok, state}
  end

  # change to handle_info
  def handle_info({:basic_deliver, payload, _meta}, state) do
    AprsWeb.Endpoint.broadcast!("aprs:messages", "aprs:position", %{payload: payload})

    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

  defp rabbitmq_url() do
    Application.get_env(:aprs_web, :rabbitmq_url)
  end

  defp log(msg) do
    Logger.info("[#{Timex.now()}] [#{__MODULE__}] #{msg}")
  end
end
