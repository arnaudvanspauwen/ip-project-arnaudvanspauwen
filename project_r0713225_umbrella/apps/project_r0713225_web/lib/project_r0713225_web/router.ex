defmodule ProjectR0713225Web.Router do
  use ProjectR0713225Web, :router
 
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ProjectR0713225Web.Plugs.Locale
  end
  
  pipeline :api do
    plug :accepts, ["json"]
    plug ProjectR0713225Web.Plugs.ApiKeyPlug
  end
 
  pipeline :project_r0713225 do
    plug ProjectR0713225Web.Pipeline
  end
 
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end
 
  pipeline :allowed_for_users do
    plug ProjectR0713225Web.Plugs.AuthorizationPlug, ["Admin", "User"]
  end
 
  pipeline :allowed_for_admins do
    plug ProjectR0713225Web.Plugs.AuthorizationPlug, ["Admin"]
  end
 
  scope "/", ProjectR0713225Web do
    pipe_through [:browser, :project_r0713225]
    get "/", SessionController, :new
    get "/login", SessionController, :new
    post "/login", SessionController, :login 
    get "/gotocreateaccount", SessionController, :gotocreateaccount
    post "/createaccount", SessionController, :createaccount
  end
  
  scope "/", ProjectR0713225Web do
    pipe_through [:browser, :project_r0713225, :ensure_auth, :allowed_for_users]
    get "/logout", SessionController, :logout
    get "/home", AnimalController, :load_animals
    get "/profile", ProfileController, :show_profile
    get "/changeusername", ProfileController, :change_user
    post "/changeusername", ProfileController, :change_user_post
    put "/changeusername", ProfileController, :change_user_post
    get "/resetpassword", ProfileController, :change_password
    post "/resetpassword", ProfileController, :change_password_post
    put "/resetpassword", ProfileController, :change_password_post
    post "/createkey", ProfileController, :create_api_key
    get "/showkey/:id", ProfileController, :showkey
    delete "/deletekey/:id", ProfileController, :deletekey 
  end
 
  scope "/admin", ProjectR0713225Web do
    pipe_through [:browser, :project_r0713225, :ensure_auth, :allowed_for_admins]
    resources "/users", UserController
    get "/", PageController, :admin_index
  end
 
  #scope "/admin", ProjectR0713225Web do
    #pipe_through [:browser, :project_r0713225, :ensure_auth]
 
    #resources "/users", UserController
  #end
 
  # Other scopes may use custom stacks.
  scope "/api", ProjectR0713225Web do
     pipe_through :api
     resources "/users", UserController, only: [] do
     resources "/animals", AnimalController
    end
  end

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
      live_dashboard "/dashboard", metrics: ProjectR0713225Web.Telemetry
    end
  end
end