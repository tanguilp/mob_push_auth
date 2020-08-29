defmodule MobPushAuthWeb.MainController do
  use MobPushAuthWeb, :controller

  alias MobPushAuth.Toto
  alias MobPushAuth.Toto.Main

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
