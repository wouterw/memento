defmodule Memento.Remembrance do
  use Memento.Web, :model

  schema "remembrances" do
    field :name, :string

    has_many :condolences, Memento.Condolence

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:name])
    |> validate_length(:name, min: 2)
  end
end
