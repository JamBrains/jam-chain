defmodule PhoenixAppWeb.TeamView do
  use PhoenixAppWeb, :view

  def sort_order(column, current_sort, current_order) do
    case {column == current_sort, current_order} do
      {true, "asc"} -> "desc"
      _ -> "asc"
    end
  end
end
