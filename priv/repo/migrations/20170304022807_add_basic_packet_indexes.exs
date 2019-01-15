defmodule AprsWeb.Repo.Migrations.AddBasicPacketIndexes do
  use Ecto.Migration

  def change do
    create index(:packets, [:srccallsign])
    create index(:packets, [:inserted_at])
    create index(:packets, [:srccallsign, :inserted_at])
  end
end
