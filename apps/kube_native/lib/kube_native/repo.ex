defmodule KubeNative.Repo do
  use Ecto.Repo,
    otp_app: :kube_native,
    adapter: Ecto.Adapters.Postgres
end
