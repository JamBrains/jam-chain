defmodule PhoenixAppWeb.AllowReplit do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _options) do
    put_resp_header(conn, "x-frame-options", "ALLOWFROM replit.com")
  end
end