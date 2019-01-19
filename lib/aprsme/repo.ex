defmodule Aprsme.Repo do
  use Ecto.Repo,
    otp_app: :aprsme,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 50

  require Logger

  alias Aprsme.Aprs.Packet

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end

  def purge_old_packets! do
    purge_count = Application.fetch_env!(:aprs_web, :purge_packet_count)
    purge_interval = Application.fetch_env!(:aprs_web, :purge_packet_interval)

    Logger.info("Purging: purge_count: #{purge_count}, purge_interval: #{purge_interval}")

    Packet |> Packet.older_than(purge_count, purge_interval) |> delete_all
  end

  def packet_count do
    aggregate(Packet, :count, :id)
  end

  def packets_through_bbox(ne, sw, age_in_minutes \\ 60) do
    callsigns =
      Packet
      |> Packet.distinct_callsigns(ne, sw)
      |> Packet.newer_than_n_minutes_ago(age_in_minutes)
      |> all

    Packet
    |> Packet.for_callsigns(callsigns)
    |> Packet.newer_than_n_minutes_ago(age_in_minutes)
    |> all
  end
end
