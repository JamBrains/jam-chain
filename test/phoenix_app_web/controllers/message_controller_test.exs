defmodule PhoenixAppWeb.MessageControllerTest do
  use PhoenixAppWeb.ConnCase

  import PhoenixApp.MatrixFixtures

  describe "switch colors" do
    @tag :only
    test "works" do
      messages = [%{ author: "alice" }, %{ author: "bob" }, %{ author: "bob" }, %{ author: "charlie" }]
      colors = PhoenixAppWeb.MessageController.alternate_colors(messages)

      assert colors == [true, false, false, true]
    end
  end
end
