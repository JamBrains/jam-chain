defmodule PhoenixAppWeb.MessageController do
  use PhoenixAppWeb, :controller

  alias PhoenixApp.Matrix
  alias PhoenixApp.Matrix.Message

  def index(conn, %{"room" => room_id} = params) do
    {cursor_type, cursor_value} = get_cursor(params)
    {messages, cursor} = get_messages(room_id, cursor_type, cursor_value)
    colors = alternate_colors(messages)
    render(conn, "index.html", messages: messages, cursor: cursor, colors: colors, room_id: room_id)
  end

  def get_cursor(%{"after" => after_cursor}) when after_cursor in [nil, ""], do: {:after_cursor, nil}
  def get_cursor(%{"after" => after_cursor}), do: {:after_cursor, after_cursor}
  def get_cursor(%{"before" => before_cursor}) when before_cursor in [nil, ""], do: {:before_cursor, nil}
  def get_cursor(%{"before" => before_cursor}), do: {:before_cursor, before_cursor}
  def get_cursor(_), do: {:after_cursor, nil}

  def get_messages(room_id, cursor_type, cursor_value) do
    %{entries: messages, metadata: cursor} = Matrix.list_messages_paged(room_id, {cursor_type, cursor_value})
    {messages, cursor}
  end

  def message_to_json(message) do
    Map.from_struct(message)
  end

  def alternate_colors(messages) do
    {_, _, colors} = Enum.reduce(messages, {nil, true, []}, fn message, {last_author, last_color, acc} ->
      if message.author == last_author or last_author == nil do
        {message.author, last_color, acc ++ [last_color]}
      else
        {message.author, not last_color, acc ++ [not last_color]}
      end
    end)

    colors
  end
end
