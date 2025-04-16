defmodule LiveGreetingWeb.GreetingLive do
  use LiveGreetingWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, name: "")}
  end

  def handle_event("update_name", %{"name" => name}, socket) do
    {:noreply, assign(socket, name: name)}
  end

  def render(assigns) do
    ~H"""
    <div class="container" style="margin-top: 2rem;">
      <h2>Live Greeting</h2>
      <form phx-change="update_name">
        <input type="text" name="name" value={@name} placeholder="Enter your name..." autocomplete="off" />
      </form>
      <p style="margin-top: 1rem; font-size: 1.2rem;">
        Hello, <%= if @name != "", do: @name, else: "stranger" %>!
      </p>
    </div>
    """
  end
end 