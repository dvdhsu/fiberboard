defmodule Mix.Tasks.ImportAttractions do
  use Mix.Task

  alias Fiberboard.Attraction

  @shortdoc "Imports attractions via a CSV file."

  def run(filename) do
    Application.ensure_all_started(:fiberboard)
    IO.puts "HI: #{inspect filename}"

    File.stream!(filename)
    |> CSV.decode(headers: true)
    |> Enum.map fn row ->
      {lng, lat} = {row["lng"], row["lat"]}
      attraction_params = row
      |> Dict.put("location", Geo.WKT.decode("POINT(#{lng} #{lat})"))
      add_attraction attraction_params
    end
  end

  def add_attraction(attraction_params) do
    changeset = Attraction.changeset(%Attraction{}, attraction_params)

    case Fiberboard.Repo.insert(changeset) do
      # if fails, just terminate, instead of catching, since we want to know
      {:ok, _} ->
        Mix.shell.info  "Inserted attraction."
    end
  end
end
