defmodule PhoenixAppWeb.TeamController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Teams
  alias PhoenixApp.Teams.Team

  def index(conn, _params) do
    teams = Teams.list_teams()
    num = length(teams)
    render(conn, "index.html", teams: teams, num_teams: num)
  end

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
