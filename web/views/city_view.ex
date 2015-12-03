defmodule Fiberboard.CityView do
  use Fiberboard.Web, :view

  def render("index.json", %{cities: cities}) do
    %{data: render_many(cities, Fiberboard.CityView, "city.json")}
  end

  def render("show.json", %{city: city, categories: categories}) do
    %{city: %{data: render_one(city, Fiberboard.CityView, "city.json")}}
    |> Map.put(:attractions, Fiberboard.AttractionView.render("index.json", attractions: city.attractions))
    |> Map.put(:attraction_categories, Fiberboard.AttractionCategoryView.render("index.json", categories: categories))
  end

  def render("city.json", %{city: city}) do
    %{id: city.id, name: city.name, center: Geo.JSON.encode(city.center),
      cover_photo_url: city.cover_photo_url}
  end
end
