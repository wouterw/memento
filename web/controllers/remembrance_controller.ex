defmodule Memento.RemembranceController do
  use Memento.Web, :controller

  alias Memento.Remembrance

  def index(conn, _params) do
    remembrances = Repo.all(Remembrance)
    render(conn, "index.html", remembrances: remembrances)
  end

  def show(conn, %{"id" => id}) do
    remembrance = Repo.get!(Remembrance, id)
    render(conn, "show.html", remembrance: remembrance)
  end
end
