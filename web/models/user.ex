defmodule Memento.User do
  use Memento.Web, :model
  import Comeonin.Bcrypt

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  @required_fields ~w(name email password)
  @optional_fields ~w(password_confirmation)

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 2)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password)
    |> encrypt_password()
  end

  defp encrypt_password(changeset) do
    if changeset.valid? do
      changeset
      |> put_change(:password_hash, hashpwsalt(changeset.changes.password))
    else
      changeset
    end
  end
end
