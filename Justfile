# Run the Phoenix dev server (http://localhost:4000)
default: dev

# List available recipes
help:
	@just --list

# Install deps and create + migrate + seed the dev database
setup:
	mix setup

# Run the Phoenix dev server (http://localhost:4000)
dev:
	mix phx.server

# Run the dev server inside an IEx session
iex:
	iex -S mix phx.server

# Drop and recreate the dev database from scratch
reset:
	mix ecto.reset

# Run the test suite
test:
	mix test

# Enter the Nix dev shell
nix:
	nix develop
