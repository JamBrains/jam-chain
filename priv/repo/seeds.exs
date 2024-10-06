# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixApp.Repo.insert!(%PhoenixApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# priv/repo/seeds.exs

Code.require_file("seeds_teams.exs", __DIR__)

# chat message seeds

#alias PhoenixApp.Repo
#alias PhoenixApp.Matrix.Message

#users = ["alice", "bob", "charlie"]
#
#for i <- 0 .. 1000 do
#  user = Enum.random(users)
#  Repo.insert!(%Message{
#    author: user,
#    body: "#{i} Hello, #{user}!",
#    event_id: "event-#{i}",
#    event_date: DateTime.utc_now() |> DateTime.add(i, :second)
#  })
#end
