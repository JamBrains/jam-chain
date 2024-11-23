defmodule PhoenixApp.Events do
  import Ecto.Query, warn: false
  alias PhoenixApp.Repo

  alias PhoenixApp.Events.Event

  def list_events do
    Repo.all(from e in Event, order_by: :name)
  end

  def get_event!(id), do: Repo.get!(Event, id)
end
