# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :userteam1,
  ecto_repos: [Userteam1.Repo]

# Configures the endpoint
config :userteam1, Userteam1Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "aUnLaA+FmkJBXz4H2MDzXpsCt5sJhWG0gs3tb6mIHDhYRl0CtnNYXu8XlAeHRUiH",
  render_errors: [view: Userteam1Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Userteam1.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :userteam1, Userteam1.Guardian,
  issuer: "userteam1",
  secret_key: "wh9E34wprc5+bHgy7Y2LMnb9VDbwhzT7hezcaEI1uYbpCNMtfYwUyF41mY7UoRav"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
