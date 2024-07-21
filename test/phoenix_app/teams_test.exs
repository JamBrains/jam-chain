defmodule PhoenixApp.TeamsTest do
  use PhoenixApp.DataCase

  alias PhoenixApp.Teams

  describe "teams" do
    alias PhoenixApp.Teams.Team

    import PhoenixApp.TeamsFixtures

    @invalid_attrs %{description: nil, homepage: nil, name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Teams.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Teams.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{description: "some description", homepage: "some homepage", name: "some name"}

      assert {:ok, %Team{} = team} = Teams.create_team(valid_attrs)
      assert team.description == "some description"
      assert team.homepage == "some homepage"
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{description: "some updated description", homepage: "some updated homepage", name: "some updated name"}

      assert {:ok, %Team{} = team} = Teams.update_team(team, update_attrs)
      assert team.description == "some updated description"
      assert team.homepage == "some updated homepage"
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Teams.update_team(team, @invalid_attrs)
      assert team == Teams.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Teams.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Teams.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Teams.change_team(team)
    end
  end
end
