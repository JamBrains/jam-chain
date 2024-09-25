defmodule PhoenixAppWeb.MessageControllerTest do
  use PhoenixAppWeb.ConnCase

  import PhoenixApp.MatrixFixtures

  @create_attrs %{author: "some author", body: "some body", event_id: "some event_id", event_date: ~U[2024-09-24 20:33:00Z]}
  @update_attrs %{author: "some updated author", body: "some updated body", event_id: "some updated event_id", event_date: ~U[2024-09-25 20:33:00Z]}
  @invalid_attrs %{author: nil, body: nil, event_id: nil, event_date: nil}

  describe "index" do
    test "lists all matrix_messages", %{conn: conn} do
      conn = get(conn, ~p"/matrix_messages")
      assert html_response(conn, 200) =~ "Listing Matrix messages"
    end
  end

  describe "new message" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/matrix_messages/new")
      assert html_response(conn, 200) =~ "New Message"
    end
  end

  describe "create message" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/matrix_messages", message: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/matrix_messages/#{id}"

      conn = get(conn, ~p"/matrix_messages/#{id}")
      assert html_response(conn, 200) =~ "Message #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/matrix_messages", message: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Message"
    end
  end

  describe "edit message" do
    setup [:create_message]

    test "renders form for editing chosen message", %{conn: conn, message: message} do
      conn = get(conn, ~p"/matrix_messages/#{message}/edit")
      assert html_response(conn, 200) =~ "Edit Message"
    end
  end

  describe "update message" do
    setup [:create_message]

    test "redirects when data is valid", %{conn: conn, message: message} do
      conn = put(conn, ~p"/matrix_messages/#{message}", message: @update_attrs)
      assert redirected_to(conn) == ~p"/matrix_messages/#{message}"

      conn = get(conn, ~p"/matrix_messages/#{message}")
      assert html_response(conn, 200) =~ "some updated author"
    end

    test "renders errors when data is invalid", %{conn: conn, message: message} do
      conn = put(conn, ~p"/matrix_messages/#{message}", message: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Message"
    end
  end

  describe "delete message" do
    setup [:create_message]

    test "deletes chosen message", %{conn: conn, message: message} do
      conn = delete(conn, ~p"/matrix_messages/#{message}")
      assert redirected_to(conn) == ~p"/matrix_messages"

      assert_error_sent 404, fn ->
        get(conn, ~p"/matrix_messages/#{message}")
      end
    end
  end

  defp create_message(_) do
    message = message_fixture()
    %{message: message}
  end
end
