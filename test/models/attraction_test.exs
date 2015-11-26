defmodule Fiberboard.AttractionTest do
  use Fiberboard.ModelCase

  alias Fiberboard.Attraction

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Attraction.changeset(%Attraction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Attraction.changeset(%Attraction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
