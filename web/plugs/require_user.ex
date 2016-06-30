defmodule Memento.RequireUser do
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(default), do: default

  def call(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_session(:redirect_path, conn.request_path)
      |> put_flash(:error, "You must log in to see this page")
      |> redirect(to: "/")
      |> halt
    end
  end
end
