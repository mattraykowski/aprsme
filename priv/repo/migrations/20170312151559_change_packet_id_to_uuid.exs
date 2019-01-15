defmodule AprsWeb.Repo.Migrations.ChangePacketIdToUuid do
  use Ecto.Migration

  alias Aprsme.Repo
  alias Aprsme.Aprs.Packet

  def up do
    Packet |> Repo.delete_all

    execute"""
      CREATE EXTENSION "uuid-ossp";
    """

    # execute """
    #   ALTER TABLE "packets" ALTER COLUMN "id" SET DATA TYPE UUID USING (uuid_generate_v4());
    # """

    drop table(:packets)

    create table(:packets, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")

      add :alive, :integer
      add :altitude, :float
      add :body, :bytea
      add :dstcallsign, :string, size: 9
      add :symbolcode, :string, size: 1
      add :symboltable, :string, size: 1
      add :speed, :float
      add :latitude, :float
      add :longitude, :float
      add :origpacket, :bytea
      add :mbits, :string, size: 3
      add :comment, :string
      add :format, :string, size: 12
      add :posambiguity, :integer
      add :posresolution, :float
      add :packet_type, :string
      add :header, :string
      add :phg, :integer
      add :messaging, :integer
      add :srccallsign, :string, size: 9
      add :telemetry, :text
      add :capabilities, :string
      add :course, :integer
      add :status, :bytea
      add :timestamp, :utc_datetime
      add :radiorange, :float
      add :destination, :string, size: 9
      add :objectname, :string, size: 9
      add :daodatumbyte, :string
      add :message, :string
      add :checksumok, :integer
      add :gpsfixstatus, :integer
      add :messageid, :string, size: 5
      add :itemname, :string, size: 9
      add :messageack, :string, size: 5
      add :messagerej, :string
      add :dxfreq, :string
      add :dxinfo, :string
      add :resultcode, :string
      add :dxcall, :string
      add :dxsource, :string
      add :dxtime, :string
      add :resultmsg, :string
      add :digipeaters, :text
      add :wx, :text
      timestamps()
    end

    create index(:packets, [:srccallsign])
    create index(:packets, [:inserted_at])
    create index(:packets, [:srccallsign, :inserted_at])
    create index(:packets, [:latitude, :longitude, :inserted_at])
  end
end
