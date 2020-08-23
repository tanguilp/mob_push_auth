defmodule MobPushAuthWeb.RegisterLoginController do
  use MobPushAuthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"login" => %{"login" => login}}) do
    conn
    |> put_session(:login, login)
    |> redirect(to: "/register/enroll")
  end
end
