defmodule PhoenixAppWeb.MessageController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Matrix
  alias PhoenixApp.Matrix.Message

  def index(conn, _params) do
    messages = Matrix.list_matrix_messages()
    render(conn, "index.html", messages: messages)
  end
end
