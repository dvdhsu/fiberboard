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
alias Fiberboard.AttractionCategory
alias Fiberboard.Attraction

london_center = %Geo.Point{coordinates: {-0.102216, 51.51786}, srid: 4326}
london_params = %{center: london_center, name: "London"}
changeset = City.changeset(%City{}, london_params)
{:ok, london} = Repo.insert(changeset)

parks_params = %{name: "Parks"}
changeset = AttractionCategory.changeset(%AttractionCategory{}, parks_params)
{:ok, parks} = Repo.insert(changeset)

landmarks_params = %{name: "Landmarks"}
changeset = AttractionCategory.changeset(%AttractionCategory{}, landmarks_params)
{:ok, landmarks} = Repo.insert(changeset)

hyde_park_coords = %Geo.Point{coordinates: {-0.177704, 51.507776}, srid: 4326}
hyde_park_params = %{
  name: "Hyde Park",
  attraction_category_id: parks.id,
  city_id: london.id,
  location: hyde_park_coords,
  description: "Hyde Park!!!!",
  image_url: "http://www.smartlayover.com/slportal/media/hyde-park.jpg",
  address: "Hyde Park, London, United Kingdom",
}

changeset = Attraction.changeset(%Attraction{}, hyde_park_params)
{:ok, hyde_park} = Repo.insert(changeset)

tower_bridge_coords = %Geo.Point{coordinates: {-0.075440, 51.505441}, srid: 4326}
tower_bridge_params = %{
  name: "Tower Bridge",
  attraction_category_id: landmarks.id,
  city_id: london.id,
  location: tower_bridge_coords,
  description: "Tower Bridge!!!!",
  image_url: "http://chsrentals.com/wp-content/uploads/2015/06/tower-bridge.jpg",
  address: "Tower Bridge Rd, London SE1 2UP, United Kingdom",
}

changeset = Attraction.changeset(%Attraction{}, tower_bridge_params)
{:ok, tower_bridge} = Repo.insert(changeset)
