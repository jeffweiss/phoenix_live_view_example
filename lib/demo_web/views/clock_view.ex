defmodule DemoWeb.ClockView do
  use Phoenix.LiveView
  import Calendar.Strftime

  def render(assigns) do
    ~E"""
    <div phx-click="boom">
      <h2>It's <%= strftime!(@date, "%r") %></h2>
    </div>
    """
  end

  def init(_session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, put_date(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    assign(socket, date: :calendar.local_time())
  end
end