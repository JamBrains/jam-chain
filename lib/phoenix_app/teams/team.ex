defmodule PhoenixApp.Teams.Team do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [:description, :homepage, :name, :lang, :lang_set, :milestone, :contact]}
  schema "teams" do
    field :description, :string
    field :homepage, :string
    field :name, :string
    field :lang, :string
    # TODO this is DB design smell
    field :lang_set, :string
    field :milestone, :integer
    field :contact, {:array, :string}

    timestamps()
  end

  @required [:name, :contact, :lang, :lang_set, :milestone]
  @optional [:homepage, :description]
  @all @required ++ @optional

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, @all)
    |> validate_required(@required)
  end
end
