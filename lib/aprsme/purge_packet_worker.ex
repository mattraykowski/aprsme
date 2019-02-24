defmodule Aprsme.PurgePacketWorker do
  require Logger

  def run() do
    {count, _} = Aprsme.Repo.purge_old_packets!()
    Logger.info("Purged #{count} packets")
  end
end
