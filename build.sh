#!/usr/bin/env bash

set -e

mix deps.get && MIX_ENV=prod mix compile && MIX_ENV=prod mix assets.deploy && MIX_ENV=prod mix release --overwrite && MIX_ENV=prod mix ecto.drop && MIX_ENV=prod mix ecto.setup
