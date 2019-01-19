defmodule AprsmeWeb.PacketController do
  use AprsmeWeb, :controller

  alias Aprsme.Aprs.Packet
  alias Aprsme.Repo

  def index(conn, params) do
    page = Packet
      |> Packet.recent
      |> Repo.paginate(params)


    render(conn, "index.html", page: page)
  end

  # def new(conn, _params) do
  #   changeset = Packet.changeset(%Packet{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"packet" => packet_params}) do
  #   changeset = Packet.changeset(%Packet{}, packet_params)

  #   case Repo.insert(changeset) do
  #     {:ok, _packet} ->
  #       conn
  #       |> put_flash(:info, "Packet created successfully.")
  #       |> redirect(to: packet_path(conn, :index))
  #     {:error, changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    packet = Repo.get!(Packet, id)
    render(conn, "show.html", packet: packet)
  end

  # def edit(conn, %{"id" => id}) do
  #   packet = Repo.get!(Packet, id)
  #   changeset = Packet.changeset(packet)
  #   render(conn, "edit.html", packet: packet, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "packet" => packet_params}) do
  #   packet = Repo.get!(Packet, id)
  #   changeset = Packet.changeset(packet, packet_params)

  #   case Repo.update(changeset) do
  #     {:ok, packet} ->
  #       conn
  #       |> put_flash(:info, "Packet updated successfully.")
  #       |> redirect(to: packet_path(conn, :show, packet))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", packet: packet, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   packet = Repo.get!(Packet, id)

  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(packet)

  #   conn
  #   |> put_flash(:info, "Packet deleted successfully.")
  #   |> redirect(to: packet_path(conn, :index))
  # end
end
