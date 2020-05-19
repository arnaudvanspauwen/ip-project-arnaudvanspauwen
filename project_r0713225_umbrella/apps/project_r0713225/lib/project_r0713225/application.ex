defmodule ProjectR0713225.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ProjectR0713225.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ProjectR0713225.PubSub}
      # Start a worker by calling: ProjectR0713225.Worker.start_link(arg)
      # {ProjectR0713225.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: ProjectR0713225.Supervisor)
  end
end
