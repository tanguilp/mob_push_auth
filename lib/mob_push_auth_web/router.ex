
defmodule MobPushAuthWeb.Router do
  use MobPushAuthWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MobPushAuthWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MobPushAuthWeb do
    pipe_through :browser

    get "/", MainController, :index
    get "/register_login", RegisterLoginController, :index
    post "/register_login", RegisterLoginController, :create

    live "/register/enroll", RegisterEnrollLive.Index
    get "/register/success", RegisterSuccessController, :index

    get "/mobile_registration/:id", MobileRegistrationController, :index
    post "/mobile_registration/:id", MobileRegistrationController, :register

    get "/auth_login", AuthLoginController, :index
    post "/auth_login", AuthLoginController, :create

    live "/auth/confirm", AuthConfirmLive.Index

    get "/mobile_auth/:id", MobileAuthController, :index
    post "/mobile_auth/:id", MobileAuthController, :confirm

    get "/auth/success", AuthSuccessController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MobPushAuthWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: MobPushAuthWeb.Telemetry
    end
  end
end
