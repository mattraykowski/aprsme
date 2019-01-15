defmodule AprsWeb.Repo.Migrations.ChangePacketTypeToType do
  use Ecto.Migration

  def change do
    rename table(:packets), :packet_type, to: :type
  end
end
