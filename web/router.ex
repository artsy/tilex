defmodule Tilex.Router do
  use Tilex.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Tilex.Plug.BasicAuth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tilex do
    pipe_through :browser # Use the default browser stack

    get "/auth/:provider", AuthController, :request
    get "/auth/:provider/callback", AuthController, :callback
    post "/auth/:provider/callback", AuthController, :callback
    delete "/auth/logout", AuthController, :delete

    get "/:name", ChannelController, :show

    get "/", PostController, :index
    resources "/posts", PostController, only: [:index, :show, :new, :create], param: "slug"
  end

  # Other scopes may use custom stacks.
  # scope "/api", Tilex do
  #   pipe_through :api
  # end
end
