defmodule AprsWeb.Repo.Migrations.ChangePacketCommentToBytea do
  use Ecto.Migration
  alias Aprsme.Repo
  alias Aprsme.Aprs.Packet

  def up do
    Packet |> Repo.delete_all

    alter table(:packets) do
      remove :comment
      add :comment, :bytea
    end
  end

  def down do
    alter table(:packets) do
      remove :comment
      add :comment, :string
    end
  end

end
