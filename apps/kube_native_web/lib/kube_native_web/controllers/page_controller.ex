defmodule KubeNativeWeb.PageController do
  use KubeNativeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
