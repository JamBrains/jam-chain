defmodule PhoenixApp.Teams do
  @moduledoc """
  The Teams context.
  """

  import Ecto.Query, warn: false
  alias PhoenixApp.Repo

  alias PhoenixApp.Teams.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(from t in Team, order_by: :name)
  end

  @doc """
  Upserts teams from a JSON payload (the clients list, as served by
  graypaper.com/clients/json), keyed by `name`.

  Existing teams are overwritten with the incoming data, new ones are
  inserted. Idempotent: running it twice never produces duplicates.
  Shared by the cron pull and the database seeds. Returns the list of
  upserted teams.
  """
  def import_teams!(json) when is_binary(json) do
    json
    |> Jason.decode!(keys: :atoms)
    |> Enum.map(fn attrs ->
      %Team{}
      |> Team.changeset(attrs)
      |> Repo.insert!(
        on_conflict: {:replace_all_except, [:id, :inserted_at]},
        conflict_target: :name
      )
    end)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end
end
