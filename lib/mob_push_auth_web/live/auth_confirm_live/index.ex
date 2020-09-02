defmodule MobPushAuthWeb.AuthConfirmLive.Index do
  use MobPushAuthWeb, :live_view

  alias MobPushAuth.SubscriptionStore
  alias MobPushAuthWeb.Router.Helpers, as: Routes

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket) do
      case SubscriptionStore.get(session["login"] || raise "Must login first") do
        %{} = subscription_info ->
          auth_id = send_auth_request(subscription_info)

          :ok = Phoenix.PubSub.subscribe(
            MobPushAuth.PubSub, IO.inspect("auth:" <> auth_id)
          )

          {:ok, socket}

        nil ->
          {:ok, redirect(socket, to: "/auth_login")}
      end
    else
      {:ok, socket}
    end
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info(:auth, socket) do
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

    auth_id = :crypto.strong_rand_bytes(32) |> Base.url_encode64(padding: false)

    message = %{
      title: "Login request",
      body: "Click here to login to the demo app",
      data: %{
        url: Routes.mobile_auth_url(MobPushAuthWeb.Endpoint, :index, auth_id)
      }
    }

    {:ok, _response} = WebPushEncryption.send_web_push(Jason.encode!(message), subscription_info)

    auth_id
  end
end
