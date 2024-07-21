defmodule Mix.Tasks.Graypaper do
  use Mix.Task

  @impl Mix.Task
  def run([]) do
    Application.ensure_all_started(:httpoison)

    for {name, url} <- graypapers() do
      IO.inspect("Downloading #{name} from #{url}")
      #zip = HTTPoison.get!(url)
    end
  end

  defp graypapers do
    artefacts = artefacts() |> Enum.sort_by(& &1["id"]) |> Enum.reverse()
    gray = Enum.find(artefacts, &(&1["name"] == "Graypaper - Gray BG"))
    white = Enum.find(artefacts, &(&1["name"] == "Graypaper - White BG"))
    lemon = Enum.find(artefacts, &(&1["name"] == "Graypaper - Gray Graphic BG"))

    %{
      "gray" => gray["archive_download_url"],
      "white" => white["archive_download_url"],
      "lemon" => lemon["archive_download_url"]
    }
  end

  defp artefacts do
    url = "https://api.github.com/repos/ggwpez/graypaper/actions/artifacts"

    response = HTTPoison.get!(url, [{"Accept", "application/vnd.github.v3+json"}])
    {:ok, data} = Jason.decode(response.body)

    data["artifacts"]
  end
end
