defmodule AprsWeb.Repo.Migrations.ChangeCallsignLengths do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :srccallsign, :string, size: 9
      modify :dstcallsign, :string, size: 9
    end
  end
end
