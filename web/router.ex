defmodule Fiberboard.Router do
  use Fiberboard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, [origin: "*"]
    plug :accepts, ["json"]
  end

  scope "/", Fiberboard do
    pipe_through :browser # Use the default browser stack
    resources "/attractions", Admin.AttractionController
    resources "/attraction_categories", Admin.AttractionCategoryController

    get "/", PageController, :index
  end

  scope "/api", Fiberboard do
    pipe_through :api
    scope "/auth" do
      post "/login", AuthenticationController, :login_or_create
      post "/logout", AuthenticationController, :logout
    end
    resources "/users", UserController, except: [:new, :edit]
    resources "/cities", CityController
  end
end
