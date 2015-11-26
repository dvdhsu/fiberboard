defmodule Fiberboard.AttractionCategoryView do
  use Fiberboard.Web, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, Fiberboard.AttractionCategoryView, "category.json")}
  end

  def render("category.json", %{attraction_category: category}) do
    %{id: category.id, name: category.name}
  end
end
