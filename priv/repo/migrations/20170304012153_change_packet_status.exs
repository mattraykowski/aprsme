defmodule AprsWeb.Repo.Migrations.ChangePacketStatus do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :status, :text
    end
  end
end
