defmodule PhoenixAppWeb.PageControllerTest do
  use PhoenixAppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "The Join Accumulate Machine"
  end

  test "GET /spec", %{conn: conn} do
    conn = get(conn, "/spec")
    assert html_response(conn, 200) =~ "Graypaper"
  end

  test "GET /tech", %{conn: conn} do
    conn = get(conn, "/tech")
    assert html_response(conn, 200) =~ "The tech stack"
  end
end
