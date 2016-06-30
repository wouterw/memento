defmodule Memento.Condolence do
  use Memento.Web, :model

  schema "condolences" do
    field :author, :string
    field :body, :string

    belongs_to :post, Memento.Remembrance

    timestamps
  end
end
