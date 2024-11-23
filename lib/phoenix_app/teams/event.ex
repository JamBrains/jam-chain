defmodule PhoenixApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :description, :string
    field :links, {:array, :string}
    field :contact, {:array, :string}
    field :when_from, :date
    field :when_to, :date
    field :where, :string

    timestamps()
  end

  @all [:description, :homepage, :name, :contact, :when_from, :when_to, :where]

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @all)
    |> validate_required(@all)
  end
end
