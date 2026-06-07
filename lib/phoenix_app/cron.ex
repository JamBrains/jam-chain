defmodule PhoenixApp.Cron do
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
    teams = PhoenixApp.Teams.import_teams!(res.body)
    Logger.info("Updated #{length(teams)} teams.")
  end
end
