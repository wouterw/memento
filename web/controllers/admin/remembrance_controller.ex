defmodule Memento.Admin.RemembranceController do
  use Memento.Web, :controller

  alias Memento.Remembrance

  def index(conn, _params) do
    remembrances = Repo.all(Remembrance)
    render(conn, "index.html", remembrances: remembrances)
  end

  def new(conn, _params) do
    changeset = Remembrance.changeset(%Remembrance{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"remembrance" => remembrance_params}) do
    changeset = Remembrance.changeset(%Remembrance{}, remembrance_params)

    case Repo.insert(changeset) do
      {:ok, _remembrance} ->
        conn
        |> put_flash(:info, "Remembrance created successfully.")
        |> redirect(to: admin_remembrance_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    remembrance = Repo.get!(Remembrance, id)
    render(conn, "show.html", remembrance: remembrance)
  end

  def edit(conn, %{"id" => id}) do
    remembrance = Repo.get!(Remembrance, id)
    changeset = Remembrance.changeset(remembrance)
    render(conn, "edit.html", remembrance: remembrance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "remembrance" => remembrance_params}) do
    remembrance = Repo.get!(Remembrance, id)
    changeset = Remembrance.changeset(remembrance, remembrance_params)

    case Repo.update(changeset) do
      {:ok, remembrance} ->
        conn
        |> put_flash(:info, "Remembrance updated successfully.")
        |> redirect(to: admin_remembrance_path(conn, :show, remembrance))
      {:error, changeset} ->
        render(conn, "edit.html", remembrance: remembrance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    remembrance = Repo.get!(Remembrance, id)

    Repo.delete!(remembrance)

    conn
    |> put_flash(:info, "Remembrance deleted successfully.")
    |> redirect(to: admin_remembrance_path(conn, :index))
  end
end
