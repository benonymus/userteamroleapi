use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :userteam1, Userteam1Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :userteam1, Userteam1.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "userteam1_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
