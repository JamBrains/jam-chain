defmodule PhoenixAppWeb.PageController do
  use PhoenixAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def spec(conn, _params) do
    render(conn, "spec.html")
  end
end
