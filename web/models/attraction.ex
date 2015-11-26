defmodule Fiberboard.Attraction do
  use Fiberboard.Web, :model

  schema "attractions" do
    field :name, :string
    field :description, :string
    field :image_url, :string
    field :location, Geo.Point
    belongs_to :city, Fiberboard.City
    belongs_to :attraction_category, Fiberboard.AttractionCategory

    timestamps
  end

  @required_fields ~w(name description location city_id attraction_category_id image_url)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
