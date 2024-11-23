defmodule PhoenixAppWeb.EventView do
  use PhoenixAppWeb, :view

  alias PhoenixApp.Events.Event

  def fmt_when(%Event{when_from: from, when_to: to} = event) when not is_nil(from) and not is_nil(to) do
    """
    #{event.when_from} - #{event.when_to}
    """
  end

  def fmt_when(%Event{when_est: est} = event) when not is_nil(est) do
    """
    #{event.when_est}
    """
  end

  def fmt_when(%Event{} = event) do
    raise ArgumentError, "Event has no date: #{inspect(event)}"
  end

  def fmt_duration(%Event{duration: duration} = event) when not is_nil(duration) do
    """
    (#{event.duration})
    """
  end

  def fmt_duration(%Event{}) do
    ""
  end

  # Format MD links to HTML links by looking up the links from a list.
  # For example:
  # >Make sure to join the [1](Matrix chat) for updates.
  # becomes:
  # >Make sure to join the <a href="Enum.at(event.links, 1)">Matrix chat</a> for updates.
def fmt_desc(%Event{long: desc, links: links} = _event) when not is_nil(desc) and is_list(links) do
    matches = Regex.scan(~r/\[([0-9]+)\]\(([^)]+)\)/, desc)
    Enum.reduce(matches, desc, fn [full_match, idx_str, name], acc ->
      case Integer.parse(idx_str) do
        {idx, _} ->
          link = Enum.at(links, idx)
          if link do
            String.replace(acc, full_match,
              "<a href=\"#{link}\" class=\"text-blue-400 hover:text-blue-300\">#{name}</a><sup>#{idx + 1}</sup>")
          else
            acc
          end
        _ -> acc
      end
    end)
    |> String.replace(~r/\n/, "<br>")
  end

  def fmt_desc(%Event{long: desc}) when not is_nil(desc), do: desc
  def fmt_desc(_), do: ""
end
