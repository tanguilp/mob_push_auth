defmodule MobPushAuthWeb.AuthConfirmLive.Index do
  use MobPushAuthWeb, :live_view

  alias MobPushAuth.SubscriptionStore

  @impl true
  def mount(_params, session, socket) do
    case SubscriptionStore.get(session["login"] || raise "Must login first") do
      %{} = subscription_info ->
        subscription_id = send_auth_request(subscription_info)

        :ok = Phoenix.PubSub.subscribe(
          MobPushAuth.PubSub, "confirmation:" <> subscription_id
        )

        {:ok, socket}

      nil ->
        {:ok, redirect(socket, to: "/auth_login")}
    end
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info(:confirmed, socket) do
    {:noreply, redirect(socket, to: "/auth/success")}
  end

  defp send_auth_request(subscription_info) do
    %{
      "endpoint" => endpoint,
      "keys" => %{
        "auth" => auth,
        "p256dh" => p256dh
      }
    } = subscription_info

    subscription_info = %{
      endpoint: endpoint,
      keys: %{
        auth: auth,
        p256dh: p256dh
      }
    }

    subscription_id = :crypto.strong_rand_bytes(32) |> Base.url_encode64(padding: false)

    message = %{
      title: "Login request",
      body: "Click here to login to the demo app",
      data: %{
        url: "localhost/some/uri/" <> subscription_id
      }
    }

    {:ok, response} = WebPushEncryption.send_web_push(Jason.encode!(message), subscription_info)

    subscription_id
  end
end
