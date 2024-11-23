defmodule PhoenixApp.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :short, :text
      add :long, :text
      add :links, {:array, :string}
      add :learn_more_id, :integer, default: 0
      add :contact, {:array, :string}
      add :when_from, :date
      add :when_to, :date
      add :when_est, :string
      add :where, :string
      add :where_link, :string
      add :duration, :string
      add :historic, :boolean, default: false

      timestamps()
    end
  end
end
