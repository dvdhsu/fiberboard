defmodule Fiberboard.AttractionView do
  use Fiberboard.Web, :view

  def render("index.json", %{attractions: attractions}) do
    %{data: render_many(attractions, Fiberboard.AttractionView, "attraction.json")}
  end

  def render("attraction.json", %{attraction: attraction}) do
    %{id: attraction.id, name: attraction.name, category_id: attraction.attraction_category_id,
      description: attraction.description, location: Geo.JSON.encode(attraction.location), image_url: attraction.image_url}
  end
end
