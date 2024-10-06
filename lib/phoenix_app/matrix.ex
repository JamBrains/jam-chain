defmodule PhoenixApp.Matrix do
  @moduledoc """
  The Matrix context.
  """

  import Ecto.Query, warn: false
  alias PhoenixApp.Repo

  alias PhoenixApp.Matrix.Message

  @doc """
  Returns the list of matrix_messages.

  ## Examples

      iex> list_matrix_messages()
      [%Message{}, ...]

  """
  def list_matrix_messages(room_id) do
    from(m in Message, where: m.room_id == ^room_id)
  end

  def list_messages_paged(room_id, {:after_cursor, c}) do
    list_matrix_messages(room_id)
    |> order_by([m], desc: m.event_date)
    |> Repo.paginate(after: c, limit: 50, cursor_fields: [{:event_date, :desc}, :body, :author])
  end

  def list_messages_paged(room_id, {:before_cursor, c}) do
    list_matrix_messages(room_id)
    |> order_by([m], desc: m.event_date)
    |> Repo.paginate(before: c, limit: 50, cursor_fields: [{:event_date, :desc}, :body, :author])
  end

  @doc """
  Gets a single message.

  Raises `Ecto.NoResultsError` if the Message does not exist.

  ## Examples

      iex> get_message!(123)
      %Message{}

      iex> get_message!(456)
      ** (Ecto.NoResultsError)

  """
  def get_message!(id), do: Repo.get!(Message, id)

  @doc """
  Creates a message.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a message.

  ## Examples

      iex> update_message(message, %{field: new_value})
      {:ok, %Message{}}

      iex> update_message(message, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_message(%Message{} = message, attrs) do
    message
    |> Message.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a message.

  ## Examples

      iex> delete_message(message)
      {:ok, %Message{}}

      iex> delete_message(message)
      {:error, %Ecto.Changeset{}}

  """
  def delete_message(%Message{} = message) do
    Repo.delete(message)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
