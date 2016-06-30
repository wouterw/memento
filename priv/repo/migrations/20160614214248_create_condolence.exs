defmodule Memento.Repo.Migrations.CreateCondolence do
  use Ecto.Migration

  def change do
    create table(:condolences) do
      add :author, :string, null: false
      add :body, :text, null: false

      timestamps null: false
    end
  end
end
