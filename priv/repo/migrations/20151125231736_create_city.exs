defmodule Fiberboard.Repo.Migrations.CreateCity do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string
      add :center, :geometry

      timestamps
    end

    create unique_index(:cities, [:name])
  end
end
