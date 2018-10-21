# Since configuration is shared in umbrella projects, this file
# should only configure the :kube_native_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :kube_native_web,
  ecto_repos: [KubeNative.Repo],
  generators: [context_app: :kube_native, binary_id: true]

# Configures the endpoint
config :kube_native_web, KubeNativeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QI+125cFBB5Z+vR6D3ULCuhDalvbkd7Gse5zkpLrjhSK7sdm8XeNeB/Gq1zO5Gt8",
  render_errors: [view: KubeNativeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: KubeNativeWeb.PubSub, adapter: Phoenix.PubSub.PG2]

config :libcluster,
  debug: true,
  topologies: []

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
