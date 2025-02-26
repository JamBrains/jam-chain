defmodule PhoenixAppWeb.TeamController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Teams
  alias PhoenixApp.Teams.Team

  def index(conn, params) do
    sort_by = params["sort"] || "name"
    sort_order = params["order"] || "asc"

    teams = Teams.list_teams()
      |> Enum.sort_by(&Map.get(&1, String.to_atom(sort_by)), &sort_compare(&1, &2, sort_order))

    render(conn, "index.html", teams: teams, sort_by: sort_by, sort_order: sort_order)
  end

  defp sort_compare(a, b, "asc"), do: a <= b
  defp sort_compare(a, b, "desc"), do: a >= b

  def new(conn, _params) do
    changeset = Teams.change_team(%Team{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"team" => team_params}) do
    case Teams.create_team(team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: Routes.team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    render(conn, "show.html", team: team)
  end

  def edit(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    changeset = Teams.change_team(team)
    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Teams.get_team!(id)

    case Teams.update_team(team, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: Routes.team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Teams.get_team!(id)
    {:ok, _team} = Teams.delete_team(team)

    conn
    |> put_flash(:info, "Team deleted successfully.")
    |> redirect(to: Routes.team_path(conn, :index))
  end
end
