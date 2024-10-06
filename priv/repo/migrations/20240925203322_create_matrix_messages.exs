defmodule PhoenixApp.Repo.Migrations.CreateMatrixMessages do
  use Ecto.Migration

  def change do
    create table(:matrix_messages) do
      add :body, :string
      add :author, :string
      add :event_id, :string
      add :event_date, :utc_datetime_usec
      add :room_id, :string

      timestamps()
    end

    create unique_index(:matrix_messages, [:event_id])
  end
end
