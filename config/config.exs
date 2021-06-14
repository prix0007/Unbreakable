# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :unbreakable,
  ecto_repos: [Unbreakable.Repo]

# Configures the endpoint
config :unbreakable, UnbreakableWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BZ33YFDh5g8p4HGUIuDs4wWcXzmF8hkUPBMKXJ+7tKnpLjdtqayqpwHXrPAMT1Ne",
  render_errors: [view: UnbreakableWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Unbreakable.PubSub,
  live_view: [signing_salt: "sgFo9tMo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
