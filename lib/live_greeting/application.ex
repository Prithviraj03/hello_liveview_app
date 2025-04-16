defmodule LiveGreeting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveGreetingWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:live_greeting, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: LiveGreeting.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: LiveGreeting.Finch},
      # Start a worker by calling: LiveGreeting.Worker.start_link(arg)
      # {LiveGreeting.Worker, arg},
      # Start to serve requests, typically the last entry
      LiveGreetingWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveGreeting.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveGreetingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
