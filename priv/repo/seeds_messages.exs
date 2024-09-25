alias PhoenixApp.Repo
alias PhoenixApp.Matrix
alias PhoenixApp.Matrix.Message

authors = ["alice", "bob", "charlie"]

# Insert some example messages
for i <- 1..10 do
  Repo.insert!(%Message{
    author: Enum.random(authors),
    body: "hey #{i}",
    event_id: "event_#{i}",
    event_date: DateTime.utc_now() |> DateTime.add(1, :day) |> DateTime.add(i, :hour)
  })
end
