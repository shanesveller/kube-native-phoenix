use Mix.Config

config :kube_native, KubeNative.Repo,
  url: System.get_env("DATABASE_URL")
