defmodule Fiberboard.City do
  use Fiberboard.Web, :model

  schema "cities" do
    field :name, :string
    field :center, Geo.Point

    has_many :attractions, Fiberboard.Attraction

    timestamps
  end

  @required_fields ~w(name center)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:name)
  end
end
