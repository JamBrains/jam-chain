# Seed teams from the canonical clients list (priv/repo/teams.json), a snapshot
# of https://graypaper.com/clients/json. Upserts by name so re-running never
# duplicates and always overwrites with the latest snapshot. The cron job keeps
# this fresh from the live endpoint after boot.
Path.join(__DIR__, "teams.json")
|> File.read!()
|> PhoenixApp.Teams.import_teams!()
