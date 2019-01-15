defmodule AprsPhoenix.Repo.Migrations.AddPostgisAndPoint do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"

    execute("SELECT AddGeometryColumn ('packets','point',4326,'POINT',2)")
    execute("CREATE INDEX packets_point_index on packets USING gist (point)")
  end

  def down do
    execute "DROP EXTENSION IF EXISTS postigs"

    alter table(:packets) do
      remove :point
    end
  end
end
