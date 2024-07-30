defmodule Mix.Tasks.Graypaper do
  use Mix.Task

  @impl Mix.Task
  def run([]) do
    PhoenixApp.Graypaper.refresh_graypaper!()
  end
end
