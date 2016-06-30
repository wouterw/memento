defmodule Memento.Repo.Migrations.CreateRemembrance do
  use Ecto.Migration

  def change do
    create table(:remembrances) do
      add :name, :string, null: false

      timestamps null: false
    end
  end
end
