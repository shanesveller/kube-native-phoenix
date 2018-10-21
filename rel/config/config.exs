use Mix.Config

port = String.to_integer(System.get_env("PORT") || "4000")
https_port = String.to_integer(System.get_env("HTTPS_PORT") || "4001")

config :kube_native_web, KubeNativeWeb.Endpoint,
  force_ssl: [hsts: false, exclude: []],
  http: [:inet6, port: port],
  https: [
    :inet6,
    port: https_port,
    cipher_suite: :strong,
    keyfile: System.get_env("TLS_KEYFILE"),
    certfile: System.get_env("TLS_CERTFILE")
  ],
  url: [host: System.get_env("HOSTNAME"), port: https_port],
  secret_key_base: System.get_env("SECRET_KEY_BASE")
