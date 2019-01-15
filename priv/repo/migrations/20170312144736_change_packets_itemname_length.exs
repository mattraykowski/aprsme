defmodule AprsWeb.Repo.Migrations.ChangePacketsItemnameLength do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :itemname, :string, size: 9
    end
  end
end
