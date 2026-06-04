defmodule PhoenixAppWeb.PageController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Events
  alias PhoenixApp.Teams

  def index(conn, _params) do
    events = Events.list_events()
    teams_count = length(Teams.list_teams())
    render(conn, "index.html", events: events, teams_count: teams_count)
  end

  def spec(conn, _params) do
    render(conn, "spec.html")
  end

  def tech(conn, _params) do
    render(conn, "tech.html")
  end
end
