defmodule MobPushAuthWeb.MobileRegisterController do
  use MobPushAuthWeb, :controller

  def index(conn, %{"id" => id}) do
    render(conn, "index.html", id: id)
  end
end
