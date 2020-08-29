defmodule MobPushAuthWeb.RegisterEnrollLive.Index do
  use MobPushAuthWeb, :live_view

  alias MobPushAuth.SubscriptionStore

  @impl true
  def mount(_params, session, socket) do
    socket =
      socket
      |> assign(:login, session["login"] || raise "Must login first")
      |> assign(:registration_id, registration_id())

    :ok = Phoenix.PubSub.subscribe(
      MobPushAuth.PubSub, "registration:" <> socket.assigns.registration_id
    )

    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info({:confirmed, subscription_info}, socket) do
    SubscriptionStore.put(socket.assigns.login, subscription_info)

    {:noreply, redirect(socket, to: "/register/success")}
  end

  defp registration_id(), do: :crypto.strong_rand_bytes(32) |> Base.url_encode64(padding: false)
end
