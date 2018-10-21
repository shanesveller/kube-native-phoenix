# Since configuration is shared in umbrella projects, this file
# should only configure the :kube_native application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :kube_native,
  ecto_repos: [KubeNative.Repo]

import_config "#{Mix.env()}.exs"
