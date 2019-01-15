defmodule AprsWeb.Repo.Migrations.ChangePacketStatusToBytea do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      remove :status

      add :status, :bytea
    end
  end
end
