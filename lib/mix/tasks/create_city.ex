defmodule Mix.Tasks.CreateCity do
  use Mix.Task

  alias Fiberboard.City

  @shortdoc "Creates a city"

  def run([city_name, s_lat, s_lng]) do
    Application.ensure_all_started(:fiberboard)
    {lat, _} = Float.parse(s_lat)
    {lng, _} = Float.parse(s_lng)
    city_center = %Geo.Point{coordinates: {lng, lat}, srid: 4326}
    city_params = %{center: city_center, name: city_name,
      cover_photo_url: "https://a0.muscache.com/ic/discover/1049?interpolation=lanczos-none&output-format=jpg&output-quality=70&v=33b4f2&downsize=1300px:730px"}
    changeset = City.changeset(%City{}, city_params)
    {:ok, city} = Fiberboard.Repo.insert(changeset)
    IO.puts "NEW-CITY-ID:'#{inspect city.id}'"
  end
end
