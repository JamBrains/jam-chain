defmodule PhoenixAppWeb.PageController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Events

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, "index.html", events: events)
  end

  def spec(conn, _params) do
    render(conn, "spec.html")
  end

  def tech(conn, _params) do
    render(conn, "tech.html")
  end
end
