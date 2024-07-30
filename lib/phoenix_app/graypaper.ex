defmodule PhoenixApp.Graypaper do
  require Logger

  def refresh_graypaper! do
    Application.ensure_all_started(:httpoison)

    for {theme, url} <- graypapers() do
      res = http_get!(url)
      # Get the actual URL, wtf...
      url = res.headers |> Enum.find(fn {k, _} -> k == "Location" end) |> elem(1)
      if url == nil do
        raise "No location header found"
      end

      res = HTTPoison.get!(url)
      data = res.body

      {:ok, file} = :zip.extract(data)
      path = "priv/static/graypaper/graypaper_#{theme}.pdf" |> String.replace(" ", "_")
      File.rename!(file, path)
    end
  end

  defp graypapers do
    artefacts = artefacts() |> Enum.sort_by(& &1["id"]) |> Enum.reverse()
    gray = Enum.find(artefacts, &(&1["name"] == "Graypaper - Gray BG"))
    white = Enum.find(artefacts, &(&1["name"] == "Graypaper - White BG"))
    lemon = Enum.find(artefacts, &(&1["name"] == "Graypaper - Gray Graphic BG"))

    %{
      "dark" => gray["archive_download_url"],
      "light" => white["archive_download_url"],
      "lemon_jelly" => lemon["archive_download_url"]
    }
  end

  defp artefacts do
    url = "https://api.github.com/repos/jambrains/graypaper/actions/artifacts"

    res = http_get!(url)
    {:ok, data} = Jason.decode(res.body)

    data["artifacts"]
  end

  def http_get!(url) do
    Logger.info("Requesting '#{url}'")
    HTTPoison.get!(url, [
      {"Accept", "application/vnd.github+json"},
      {"Authorization", "Bearer #{System.fetch_env!("GITHUB_TOKEN")}"},
      {"X-GitHub-Api-Version", "2022-11-28"}
    ])
  end
end
