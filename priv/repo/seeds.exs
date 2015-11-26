# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fiberboard.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fiberboard.Repo
alias Fiberboard.City

london_center = %Geo.Point{coordinates: {-0.102216, 51.51786}, srid: 4326}
london_params = %{center: london_center, name: "London"}

changeset = City.changeset(%City{}, london_params)

Repo.insert(changeset)
