defmodule Userteam1Web.Router do
  use Userteam1Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", Userteam1Web do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/teams", TeamController)
    resources("/users", UserController)
    resources("/roles", RoleController)
  end

  # Other scopes may use custom stacks.
  # scope "/api", Userteam1Web do
  #   pipe_through :api
  # end
end
