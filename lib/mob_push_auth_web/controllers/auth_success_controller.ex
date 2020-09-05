defmodule MobPushAuthWeb.AuthSuccessController do
  use MobPushAuthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
