defmodule FreteValidate.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FreteValidateWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FreteValidate.PubSub},
      # Start the Endpoint (http/https)
      FreteValidateWeb.Endpoint
      # Start a worker by calling: FreteValidate.Worker.start_link(arg)
      # {FreteValidate.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FreteValidate.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FreteValidateWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
