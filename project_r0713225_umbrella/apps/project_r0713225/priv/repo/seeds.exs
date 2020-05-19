# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ProjectR0713225.Repo.insert!(%ProjectR0713225.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, _cs} =
    ProjectR0713225.UserContext.create_user(%{"password" => "t", "password_confirmation" => "t", "role" => "User", "username" => "user"})
 
{:ok, _cs} =
    ProjectR0713225.UserContext.create_user(%{"password" => "t", "password_confirmation" => "t", "role" => "Admin", "username" => "admin"})