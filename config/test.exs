use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fiberboard, Fiberboard.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :fiberboard, Fiberboard.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fiberboard_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]

# import the secrets file
import_config "test.secret.exs"
