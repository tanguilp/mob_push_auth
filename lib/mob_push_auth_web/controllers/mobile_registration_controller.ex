defmodule MobPushAuthWeb.MobileRegistrationController do
  use MobPushAuthWeb, :controller

  def index(conn, %{"id" => id}) do
    app_key = Application.fetch_env!(:web_push_encryption, :vapid_details)[:public_key]

    render(conn, "index.html", id: id, app_key: app_key)
  end

  def register(conn, %{"id" => id, "subscription_info" => subscription_info}) do
    message = {:confirmed, Jason.decode!(subscription_info)}

    Phoenix.PubSub.broadcast_from!(MobPushAuth.PubSub, self(), "registration:" <> id, message)

    render(conn, "success.html")
  end
end
