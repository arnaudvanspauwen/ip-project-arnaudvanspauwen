defmodule ProjectR0713225Web.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ProjectR0713225Web.Telemetry,
      # Start the Endpoint (http/https)
      ProjectR0713225Web.Endpoint
      # Start a worker by calling: ProjectR0713225Web.Worker.start_link(arg)
      # {ProjectR0713225Web.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProjectR0713225Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ProjectR0713225Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
