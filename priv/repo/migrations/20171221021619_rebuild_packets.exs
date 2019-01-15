defmodule AprsWeb.Repo.Migrations.RebuildPackets do
  use Ecto.Migration

  def up do
    drop table(:packets)

    create table(:packets) do
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

      add :comment, :bytea

      add :format, :string, size: 12
      add :posambiguity, :integer
      add :posresolution, :float
      add :type, :string
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

    execute("CREATE EXTENSION IF NOT EXISTS postgis")
    execute("SELECT AddGeometryColumn ('packets','point',4326,'POINT',2)")
    execute("CREATE INDEX packets_point_index on packets USING gist (point)")
  end

  def down do
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
      add :comment, :bytea
      add :format, :string, size: 12
      add :posambiguity, :integer
      add :posresolution, :float
      add :type, :string
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
