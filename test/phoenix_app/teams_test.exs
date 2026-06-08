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
      valid_attrs = %{
        description: "some description",
        homepage: "some homepage",
        name: "some name",
        lang: "some lang",
        lang_set: "some lang_set",
        milestone: 0,
        contact: ["some contact"]
      }

      assert {:ok, %Team{} = team} = Teams.create_team(valid_attrs)
      assert team.description == "some description"
      assert team.homepage == "some homepage"
      assert team.name == "some name"
      assert team.lang == "some lang"
      assert team.lang_set == "some lang_set"
      assert team.milestone == 0
      assert team.contact == ["some contact"]
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Teams.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()

      update_attrs = %{
        description: "some updated description",
        homepage: "some updated homepage",
        name: "some updated name"
      }

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

    test "create_team/1 rejects a duplicate name" do
      team_fixture(%{name: "Tessera"})

      assert {:error, changeset} =
               Teams.create_team(%{
                 name: "Tessera",
                 lang: "Rust",
                 lang_set: "B",
                 milestone: 0,
                 contact: []
               })

      assert "has already been taken" in errors_on(changeset).name
      assert length(Teams.list_teams()) == 1
    end
  end

  describe "import_teams!/1" do
    alias PhoenixApp.Teams.Team

    # A trimmed sample of the graypaper.com/clients/json payload, including the
    # extra `languages` field the schema ignores. Hardcoded so the test never
    # touches the network.
    @payload """
    [
      {
        "name": "Tessera",
        "description": "A Team of Web3 Researchers+Devs; Currently private.",
        "homepage": "https://chainscore.finance/",
        "languages": [{"name": "Python", "set": "C"}],
        "milestone": 0,
        "contact": [],
        "lang": "Python",
        "lang_set": "C"
      },
      {
        "name": "Strawberry",
        "description": "Go implementation of Jam.",
        "homepage": "https://www.eiger.co/",
        "languages": [{"name": "Go", "set": "A"}],
        "milestone": 0,
        "contact": ["hello@eiger.co"],
        "lang": "Go",
        "lang_set": "A"
      }
    ]
    """

    test "inserts every team from the payload" do
      Teams.import_teams!(@payload)

      names = Teams.list_teams() |> Enum.map(& &1.name)
      assert names == ["Strawberry", "Tessera"]

      tessera = Repo.get_by!(Team, name: "Tessera")
      assert tessera.lang == "Python"
      assert tessera.lang_set == "C"
    end

    test "is idempotent — re-importing never duplicates" do
      Teams.import_teams!(@payload)
      Teams.import_teams!(@payload)

      assert Repo.aggregate(Team, :count) == 2
      assert Repo.aggregate(from(t in Team, where: t.name == "Tessera"), :count) == 1
    end

    test "overwrites existing teams on re-import, keeping a single row" do
      Teams.import_teams!(@payload)
      original = Repo.get_by!(Team, name: "Tessera")

      updated_payload = String.replace(@payload, "\"Python\"", "\"Rust\"")
      Teams.import_teams!(updated_payload)

      tessera = Repo.get_by!(Team, name: "Tessera")
      assert tessera.id == original.id
      assert tessera.lang == "Rust"
      assert Repo.aggregate(Team, :count) == 2
    end
  end
end
