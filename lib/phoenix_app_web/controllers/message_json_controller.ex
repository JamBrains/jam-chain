defmodule PhoenixAppWeb.MessageJsonController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Matrix
  alias PhoenixApp.Matrix.Message
  alias PhoenixAppWeb.MessageController, as: MC

  def index(conn, %{"room" => room_id}) do
    {cursor_type, cursor_value} = MC.get_cursor(conn.params)
    {messages, cursor} = MC.get_messages(room_id, cursor_type, cursor_value)

    json_data = %{
      messages: Enum.map(messages, &message_to_json/1),
      cursor: cursor_to_json(cursor)
    }

    json(conn, json_data)
  end

  defp cursor_to_json(cursor) do
    Map.from_struct(cursor)
  end

  defp message_to_json(message) do
    %{
      author: message.author,
      body: message.body,
      event_id: message.event_id,
      event_date: message.event_date,
      room_id: message.room_id
    }
  end
end
