# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :project_r0713225,
  ecto_repos: [ProjectR0713225.Repo]

config :i18n, ProjectR0713225Web.Gettext,
  locales: ~w(en nl),
  default_locale: "en"

config :project_r0713225_web,
  ecto_repos: [ProjectR0713225.Repo],
  generators: [context_app: :project_r0713225]

# Configures the endpoint
config :project_r0713225_web, ProjectR0713225Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x2kgKG0WbTCfgDbBj9FdssNvExBD0ZAnE5izzj/DTKsGnZ7ZWURV8IyZnqhm+Y1Z",
  render_errors: [view: ProjectR0713225Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ProjectR0713225.PubSub,
  live_view: [signing_salt: "RORUFAsz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardin 
config :project_r0713225_web, ProjectR0713225Web.Guardian,
  issuer: "project_r0713225_web",
  secret_key: "eMV6qnoIudepBw4TFtfeI7xGHfSR9QrQcf7LSYIlYg9vzMB8uXUD8fFxhojmXaKI" 

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
