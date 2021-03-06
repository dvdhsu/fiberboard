defmodule Fiberboard.Admin.AttractionController do
  use Fiberboard.Web, :controller

  alias Fiberboard.Attraction

  plug :scrub_params, "attraction" when action in [:create, :update]

  def index(conn, _params) do
    attractions = Repo.all(Attraction) |> Repo.preload([:city, :attraction_category])
    render(conn, "index.html", attractions: attractions)
  end

  def new(conn, _params) do
    changeset = Attraction.changeset(%Attraction{})
    cities_dict = List.foldl(Repo.all(Fiberboard.City), %{}, fn (c, acc) -> Dict.put(acc, c.name, c.id) end)
    categories_dict = List.foldl(Repo.all(Fiberboard.AttractionCategory), %{}, fn (c, acc) -> Dict.put(acc, c.name, c.id) end)
    render(conn, "new.html", changeset: changeset, cities_dict: cities_dict, categories_dict: categories_dict)
  end

  def create(conn, %{"attraction" => attraction_params}) do
    location = parse_params_location(attraction_params)
    attraction_params = Dict.put(attraction_params, "location", location)
    changeset = Attraction.changeset(%Attraction{}, attraction_params)

    case Repo.insert(changeset) do
      {:ok, _attraction} ->
        conn
        |> put_flash(:info, "Attraction created successfully.")
        |> redirect(to: attraction_path(conn, :index))
      {:error, changeset} ->
        cities_dict = List.foldl(Repo.all(Fiberboard.City), %{}, fn (c, acc) -> Dict.put(acc, c.name, c.id) end)
        categories_dict = List.foldl(Repo.all(Fiberboard.AttractionCategory), %{}, fn (c, acc) -> Dict.put(acc, c.name, c.id) end)
        render(conn, "new.html", changeset: changeset, cities_dict: cities_dict, categories_dict: categories_dict)
    end
  end

  def show(conn, %{"id" => id}) do
    attraction = Repo.get!(Attraction, id)
    render(conn, "show.html", attraction: attraction)
  end

  def edit(conn, %{"id" => id}) do
    attraction = Repo.get!(Attraction, id)
    changeset = Attraction.changeset(attraction)
    cities_dict = List.foldl(Repo.all(Fiberboard.City), %{}, fn (c, acc) -> Dict.put(acc, c.name, c.id) end)
    categories_dict = List.foldl(Repo.all(Fiberboard.AttractionCategory), %{}, fn (c, acc) -> Dict.put(acc, c.name, c.id) end)
    render(conn, "edit.html",  attraction: attraction, changeset: changeset, cities_dict: cities_dict, categories_dict: categories_dict)
  end

  def update(conn, %{"id" => id, "attraction" => attraction_params}) do
    attraction = Repo.get!(Attraction, id)
    changeset = Attraction.changeset(attraction, attraction_params)

    case Repo.update(changeset) do
      {:ok, attraction} ->
        conn
        |> put_flash(:info, "Attraction updated successfully.")
        |> redirect(to: attraction_path(conn, :show, attraction))
      {:error, changeset} ->
        render(conn, "edit.html", attraction: attraction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    attraction = Repo.get!(Attraction, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(attraction)

    conn
    |> put_flash(:info, "Attraction deleted successfully.")
    |> redirect(to: attraction_path(conn, :index))
  end

  defp parse_params_location(params) do
    if params["geopoint"] && String.length(params["geopoint"]) > 0 do
      Geo.WKT.decode(params["geopoint"])
    else
      nil
    end
  end
end
