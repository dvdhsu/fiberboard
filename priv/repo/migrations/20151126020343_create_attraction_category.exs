defmodule Fiberboard.Repo.Migrations.CreateAttractionCategory do
  use Ecto.Migration

  def change do
    create table(:attraction_categories) do
      add :name, :string

      timestamps
    end

    create index(:attraction_categories, [:name], unique: true)
  end
end
