defmodule Fiberboard.AttractionCategory do
  use Fiberboard.Web, :model

  schema "attraction_categories" do
    field :name, :string

    has_many :attractions, Fiberboard.Attraction

    timestamps
  end

  @required_fields ~w(name)
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
