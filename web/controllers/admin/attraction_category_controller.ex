defmodule Fiberboard.Admin.AttractionCategoryController do
  use Fiberboard.Web, :controller

  alias Fiberboard.AttractionCategory

  plug :scrub_params, "attraction_category" when action in [:create, :update]

  def index(conn, _params) do
    attraction_categories = Repo.all(AttractionCategory)
    render(conn, "index.html", attraction_categories: attraction_categories)
  end

  def new(conn, _params) do
    changeset = AttractionCategory.changeset(%AttractionCategory{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"attraction_category" => attraction_category_params}) do
    changeset = AttractionCategory.changeset(%AttractionCategory{}, attraction_category_params)

    case Repo.insert(changeset) do
      {:ok, _attraction_category} ->
        conn
        |> put_flash(:info, "Attraction category created successfully.")
        |> redirect(to: attraction_category_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    attraction_category = Repo.get!(AttractionCategory, id)
    render(conn, "show.html", attraction_category: attraction_category)
  end

  def edit(conn, %{"id" => id}) do
    attraction_category = Repo.get!(AttractionCategory, id)
    changeset = AttractionCategory.changeset(attraction_category)
    render(conn, "edit.html", attraction_category: attraction_category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "attraction_category" => attraction_category_params}) do
    attraction_category = Repo.get!(AttractionCategory, id)
    changeset = AttractionCategory.changeset(attraction_category, attraction_category_params)

    case Repo.update(changeset) do
      {:ok, attraction_category} ->
        conn
        |> put_flash(:info, "Attraction category updated successfully.")
        |> redirect(to: attraction_category_path(conn, :show, attraction_category))
      {:error, changeset} ->
        render(conn, "edit.html", attraction_category: attraction_category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attraction_category = Repo.get!(AttractionCategory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attraction_category)

    conn
    |> put_flash(:info, "Attraction category deleted successfully.")
    |> redirect(to: attraction_category_path(conn, :index))
  end
end
