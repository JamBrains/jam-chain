defmodule PhoenixApp.MatrixFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixApp.Matrix` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        author: "some author",
        body: "some body",
        event_date: ~U[2024-09-24 20:33:00Z],
        event_id: "some event_id"
      })
      |> PhoenixApp.Matrix.create_message()

    message
  end
end
