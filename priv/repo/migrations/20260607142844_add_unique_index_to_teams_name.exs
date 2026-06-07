defmodule PhoenixApp.Repo.Migrations.AddUniqueIndexToTeamsName do
  use Ecto.Migration

  def change do
    create unique_index(:teams, [:name])
  end
end
