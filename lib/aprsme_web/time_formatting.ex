defmodule AprsmeWeb.TimeFormatting do
  def format_ts(time, format \\ "%F %T %z") do
    time |> Timex.format!(format, :strftime)
  end
end
