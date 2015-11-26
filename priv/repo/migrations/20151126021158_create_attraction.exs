defmodule Fiberboard.Repo.Migrations.CreateAttraction do
  use Ecto.Migration

  def change do
    create table(:attractions) do
      add :name, :string
      add :description, :string
      add :image_url, :string
      add :city_id, references(:cities)
      add :attraction_category_id, references(:attraction_categories)
      add :location, :geometry
      add :address, :string

      timestamps
    end
    create index(:attractions, [:city_id])
    create index(:attractions, [:attraction_category_id])

  end
end
