defmodule PhoenixApp.TeamsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixApp.Teams` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        description: "some description",
        homepage: "some homepage",
        name: "some name",
        lang: "some lang",
        lang_set: "some lang_set",
        milestone: 0,
        contact: ["some contact"]
      })
      |> PhoenixApp.Teams.create_team()

    team
  end
end
