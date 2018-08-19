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

  pipeline :browser_session do
    plug(
      Guardian.Plug.Pipeline,
      module: Userteam1.Guardian,
      error_handler: Userteam1.AuthErrorHandler
    )

    plug(Guardian.Plug.VerifySession)
    plug(Guardian.Plug.LoadResource)
  end

  pipeline :auth do
    plug(Guardian.Plug.EnsureAuthenticated, handler: Userteam1.AuthHandler)
  end

  scope "/admin", Userteam1Web do
    pipe_through([:browser, :browser_session, :auth])

    get("/main", PageController, :index)
    resources("/teams", TeamController)
    resources("/users", UserController)
    resources("/roles", RoleController)
  end

  scope "/", Userteam1Web do
    # Use the default browser stack
    pipe_through(:browser)

    resources("/", SessionController, only: [:index, :create, :delete])
  end

  # Other scopes may use custom stacks.
  # scope "/api", Userteam1Web do
  #   pipe_through :api
  # end
end
