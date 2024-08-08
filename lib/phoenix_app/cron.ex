defmodule PhoenixApp.Cron do
  alias PhoenixApp.Repo
  alias PhoenixApp.Teams.Team
  require Logger
  use GenServer

  @url "https://graypaper.com/clients/json"
  @pull_interval_min 60

  def start_link(opts) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @impl true
  def init(_) do
    Process.send_after(self(), :pull, 1 * 1_000)

    {:ok, nil}
  end

  @impl true
  def handle_info(:pull, nil) do
    Process.send_after(self(), :pull, @pull_interval_min * 60 * 1_000)

    try do
      refresh_teams!()
    rescue
      e -> Logger.error("Failed to refresh teams: #{inspect(e)}")
    end

    try do
      refresh_graypaper!()
    rescue
      e -> Logger.error("Failed to refresh graypaper: #{inspect(e)}")
    end

    {:noreply, nil}
  end

  def refresh_graypaper! do
    Logger.info("Pulling graypaper...")
    PhoenixApp.Graypaper.refresh_graypaper!()
  end

  def refresh_teams! do
    Logger.info("Pulling repos...")
    res = HTTPoison.get!(@url, timeout: 60 * 1_000)
    parsed = Poison.decode!(res.body, as: %{}, keys: :atoms)

    for team <- parsed do
      case Repo.get_by(Team, name: team.name) do
        nil  -> %Team{}
        team -> team
      end
      |> Team.changeset(team)
      |> Repo.insert_or_update!()
    end

    Logger.info("Updated #{length(parsed)} teams.")
  end
end
