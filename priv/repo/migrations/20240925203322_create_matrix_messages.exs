defmodule PhoenixApp.Repo.Migrations.CreateMatrixMessages do
  use Ecto.Migration

  def change do
    create table(:matrix_messages) do
      add :body, :string
      add :author, :string
      add :event_id, :string
      add :event_date, :utc_datetime_usec

      timestamps()
    end
  end
end
