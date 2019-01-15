defmodule AprsWeb.Repo.Migrations.ChangeMbitsLength do
  use Ecto.Migration

  alias Aprsme.Repo
  alias Aprsme.Aprs.Packet

  def up do
    Repo.delete_all(Packet)

    alter table(:packets) do
      modify :mbits, :string, size: 3
    end
  end

  def down do
    alter table(:packets) do
      modify :mbits, :string
    end
  end
end
