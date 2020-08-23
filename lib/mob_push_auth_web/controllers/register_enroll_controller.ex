defmodule MobPushAuthWeb.RegisterEnrollController do
  use MobPushAuthWeb, :controller

  alias MobPushAuth.RegistrationChallenge

  def index(conn, _params) do
    challenge =
      conn
      |> get_session(:login)
      |> RegistrationChallenge.new()

    qrcode_settings = %QRCode.SvgSettings{qrcode_color: "#4169e1"}

    conn
    |> put_session(:registration_challenge, challenge)
    |> render("index.html", url: challenge.url, settings: qrcode_settings)
  end
end
