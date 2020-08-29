defmodule MobPushAuthWeb.AuthLoginController do
  use MobPushAuthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"login" => %{"login" => login}}) do
    conn
    |> put_session(:login, login)
    |> redirect(to: "/auth/confirm")
  end
end
