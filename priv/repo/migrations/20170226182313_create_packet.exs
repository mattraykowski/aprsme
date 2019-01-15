defmodule AprsWeb.Repo.Migrations.CreatePacket do
  use Ecto.Migration

  def change do
    create table(:packets) do
      add :alive, :integer
      add :altitude, :float
      add :body, :bytea
      add :dstcallsign, :string
      add :symbolcode, :string
      add :symboltable, :string
      add :speed, :float
      add :latitude, :float
      add :longitude, :float
      add :origpacket, :bytea
      add :mbits, :string
      add :comment, :string
      add :format, :string
      add :posambiguity, :integer
      add :posresolution, :float
      add :packet_type, :string
      add :header, :string
      add :phg, :integer
      add :messaging, :integer
      add :srccallsign, :string
      add :telemetry, :text
      add :capabilities, :string
      add :course, :integer
      add :status, :string
      add :timestamp, :utc_datetime
      add :radiorange, :float
      add :destination, :string
      add :objectname, :string
      add :daodatumbyte, :string
      add :message, :string
      add :checksumok, :integer
      add :gpsfixstatus, :integer
      add :messageid, :string
      add :itemname, :string
      add :messageack, :string
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

  end
end
