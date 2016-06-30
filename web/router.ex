defmodule Memento.Router do
  use Memento.Web, :router

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

  pipeline :authenticated do
    plug Memento.Auth, repo: Memento.Repo
    plug Memento.RequireUser
  end

  scope "/", Memento do
    pipe_through :browser

    get "/", PageController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/remembrances", RemembranceController, only: [:index, :show]
  end

  scope "/admin", Memento, as: :admin do
    pipe_through [:browser, :authenticated]

    resources "/users", Admin.UserController
    resources "/remembrances", Admin.RemembranceController
  end
end
