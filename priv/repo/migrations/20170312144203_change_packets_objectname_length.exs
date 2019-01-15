defmodule AprsWeb.Repo.Migrations.ChangePacketsObjectnameLength do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :objectname, :string, size: 9
    end
  end
end
