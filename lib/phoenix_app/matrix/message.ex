defmodule PhoenixApp.Matrix.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "matrix_messages" do
    field :author, :string
    field :body, :string
    field :event_id, :string
    field :event_date, :utc_datetime_usec

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :author, :event_id, :event_date])
    |> validate_required([:body, :author, :event_id, :event_date])
  end
end
