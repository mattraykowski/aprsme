defmodule AprsWeb.Repo.Migrations.ChangePacketsMessageidMessageackLength do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :messageid, :string, size: 5
      modify :messageack, :string, size: 5
    end
  end
end
