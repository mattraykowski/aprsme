defmodule AprsWeb.Repo.Migrations.ChangePacketFormatLength do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :format, :string, size: 12
    end
  end
end
