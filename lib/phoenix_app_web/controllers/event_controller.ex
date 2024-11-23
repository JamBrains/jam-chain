defmodule PhoenixAppWeb.EventController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Events

  def index(conn, _params) do
    events = Events.list_events()
    num = length(events)
    render(conn, "index.html", events: events, num_events: num)
  end

  def show(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    render(conn, "show.html", event: event)
  end
end
