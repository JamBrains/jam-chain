defmodule PhoenixApp.MatrixTest do
  use PhoenixApp.DataCase

  alias PhoenixApp.Matrix

  describe "matrix_messages" do
    alias PhoenixApp.Matrix.Message

    import PhoenixApp.MatrixFixtures

    @invalid_attrs %{author: nil, body: nil, event_id: nil, event_date: nil}

    test "list_matrix_messages/0 returns all matrix_messages" do
      message = message_fixture()
      assert Matrix.list_matrix_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Matrix.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      valid_attrs = %{author: "some author", body: "some body", event_id: "some event_id", event_date: ~U[2024-09-24 20:33:00Z]}

      assert {:ok, %Message{} = message} = Matrix.create_message(valid_attrs)
      assert message.author == "some author"
      assert message.body == "some body"
      assert message.event_id == "some event_id"
      assert message.event_date == ~U[2024-09-24 20:33:00Z]
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Matrix.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      update_attrs = %{author: "some updated author", body: "some updated body", event_id: "some updated event_id", event_date: ~U[2024-09-25 20:33:00Z]}

      assert {:ok, %Message{} = message} = Matrix.update_message(message, update_attrs)
      assert message.author == "some updated author"
      assert message.body == "some updated body"
      assert message.event_id == "some updated event_id"
      assert message.event_date == ~U[2024-09-25 20:33:00Z]
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Matrix.update_message(message, @invalid_attrs)
      assert message == Matrix.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Matrix.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Matrix.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Matrix.change_message(message)
    end
  end
end
