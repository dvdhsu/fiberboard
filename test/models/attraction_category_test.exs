defmodule Fiberboard.AttractionCategoryTest do
  use Fiberboard.ModelCase

  alias Fiberboard.AttractionCategory

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = AttractionCategory.changeset(%AttractionCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = AttractionCategory.changeset(%AttractionCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
