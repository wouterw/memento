# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Memento.Repo.insert!(%Memento.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Memento.{User, Repo}

%User{}
|> User.changeset(%{name: "Wouter", email: "wouter@example.com", password: "password", password_confirmation: "password"})
|> Repo.insert!()
