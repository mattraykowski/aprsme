defmodule AprsmeWeb.AprsChannel do
  require Logger
  alias Aprsme.Repo

  # When this changes, the zoom level setting in the main Vue app
  # component also needs to be changed.
  @min_zoom_level 9

  use AprsmeWeb, :channel

  def join("aprs:messages", _params, socket) do
    Logger.debug("user JOIN: aprs:messages")
    {:ok, socket }
  end

  def handle_info(msg, state) do
    IO.puts "== handle_info: msg: #{msg}, state: #{inspect state}"
    {:ok, state}
  end

  # always send the packets in the map bounds since the JS code treats
  # existing stations as updates
  def handle_in("map_bounds", %{"ne" => ne, "sw" => sw, "zoom" => zoom,} = params, socket) do
    Logger.debug "==> map_bounds: #{inspect ne}, #{inspect sw}, zoom: #{zoom}"

    socket = assign(socket, :map_bounds, params)

    if zoom >= @min_zoom_level do
      packets = Repo.packets_through_bbox(ne, sw, 60)

      Enum.each(packets, fn(packet) ->
        {:ok, packet_json} = Poison.encode(packet)
        push socket, "aprs:position", %{payload: packet_json}
      end)
    end

    {:reply, :ok, socket}
  end

  intercept ["aprs:position"]
  def handle_out("aprs:position" = msg, %{payload: payload} = params, socket) do
    aprs_packet = Poison.decode! payload

    if map_bounds_present?(socket) && position_in_view?(aprs_packet, socket.assigns[:map_bounds]) do
      Logger.debug "<--- handle_out: aprs:position: position in-bounds: #{aprs_packet["srccallsign"]}"
      push socket, msg, params
    end

    {:noreply, socket}
  end

  # TODO: fix this for positive longitude and negative latitude
  defp position_in_view?(position, bounds) do
    bounds["zoom"] >= @min_zoom_level &&
    position["latitude"] <= bounds["ne"]["lat"] && position["latitude"] >= bounds["sw"]["lat"] &&
    position["longitude"] <= bounds["ne"]["lng"] && position["longitude"] >= bounds["sw"]["lng"]
  end

  defp map_bounds_present?(socket) do
    socket.assigns[:map_bounds]
  end

end
