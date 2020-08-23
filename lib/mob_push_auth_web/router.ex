defmodule MobPushAuthWeb.Router do
  use MobPushAuthWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MobPushAuthWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/register/login", RegisterLoginController, :index
    post "/register/login", RegisterLoginController, :create
    get "/register/enroll", RegisterEnrollController, :index
    get "/mobile_register_url", MobileRegisterController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MobPushAuthWeb do
  #   pipe_through :api
  # end
end
