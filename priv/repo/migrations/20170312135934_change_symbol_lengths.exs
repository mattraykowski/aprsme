defmodule AprsWeb.Repo.Migrations.ChangeSymbolLengths do
  use Ecto.Migration

  def change do
    alter table(:packets) do
      modify :symbolcode, :string, size: 1
      modify :symboltable, :string, size: 1
    end
  end

end
