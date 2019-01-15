defmodule AprsWeb.Repo.Migrations.ChangePacketsDestinationMaxLength do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :destination, :string, size: 9
    end
  end
end
