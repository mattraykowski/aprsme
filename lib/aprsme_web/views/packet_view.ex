defmodule AprsmeWeb.PacketView do
  use AprsmeWeb, :view

  def attr_row(attr, title) do
    if attr do
      content_tag :tr do
        [
          content_tag(:td, title),
          content_tag(:td, attr)
        ]
      end
    end
  end

end
