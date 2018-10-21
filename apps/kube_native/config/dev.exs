# Since configuration is shared in umbrella projects, this file
# should only configure the :kube_native application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :kube_native, KubeNative.Repo,
  database: "kube_native_dev",
  pool_size: 10
