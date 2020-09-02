defmodule MobPushAuthWeb.MobileAuthController do
  use MobPushAuthWeb, :controller

  def index(conn, %{"id" => id}) do
    render(conn, "index.html", id: id)
  end

  def confirm(conn, %{"id" => id, "submit" => "Confirm"}) do
    Phoenix.PubSub.broadcast_from!(MobPushAuth.PubSub, self(), IO.inspect("auth:" <> id), :auth)

    render(conn, "success.html")
  end

  def confirm(conn, %{"id" => id, "submit" => "Deny"}) do
    Phoenix.PubSub.broadcast_from!(MobPushAuth.PubSub, self(), "auth:" <> id, :deny)

    render(conn, "deny.html")
  end
end
