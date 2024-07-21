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

alias PhoenixApp.Repo
alias PhoenixApp.Accounts.User

Code.require_file("seeds_teams.exs", __DIR__)
