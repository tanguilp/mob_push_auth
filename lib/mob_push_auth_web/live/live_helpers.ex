defmodule MobPushAuthWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `MobPushAuthWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, MobPushAuthWeb.RegisterEnrollLive.FormComponent,
        id: @register_enroll.id || :new,
        action: @live_action,
        register_enroll: @register_enroll,
        return_to: Routes.register_enroll_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, MobPushAuthWeb.ModalComponent, modal_opts)
  end
end
