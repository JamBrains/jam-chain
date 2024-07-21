defmodule PhoenixApp.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :description, :text
      add :homepage, :string
      add :lang, :string
      add :lang_set, :string
      add :milestone, :integer
      add :contact, {:array, :string}

      timestamps()
    end
  end
end
