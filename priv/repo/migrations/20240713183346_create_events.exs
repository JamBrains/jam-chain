defmodule PhoenixApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :text
      add :links, {:array, :string}
      add :contact, {:array, :string}
      add :when_from, :date
      add :when_to, :date
      add :where, :string

      timestamps()
    end
  end
end
