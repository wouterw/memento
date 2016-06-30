defmodule Memento.SessionController do
  use Memento.Web, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pwd}}) do
    case Memento.Auth.login_by_email_and_pwd(conn, email, pwd, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Memento.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
