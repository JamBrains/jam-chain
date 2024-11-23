defmodule PhoenixApp.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :name, :string
    field :short, :string
    field :long, :string
    field :links, {:array, :string}
    field :learn_more_id, :integer, default: 0
    field :contact, {:array, :string}
    field :when_from, :date
    field :when_to, :date
    field :when_est, :string
    field :where, :string
    field :where_link, :string
    field :duration, :string
    field :historic, :boolean, default: false

    timestamps()
  end

  @all [:homepage, :name, :contact, :where]

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @all ++ [:when_to, :when_from, :when_est, :where_link, :duration, :long, :short, :links, :historic, :learn_more_id])
    |> validate_required(@all)
  end
end
