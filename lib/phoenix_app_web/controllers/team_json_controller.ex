defmodule PhoenixAppWeb.TeamJsonController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Teams

  def index(conn, _params) do
    teams = Teams.list_teams()

    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
    |> Plug.Conn.send_resp(200, Jason.encode!(teams, pretty: true))
  end
end
