defmodule UnbreakableWeb.GoalView do
  use UnbreakableWeb, :view

  def bar_length(0), do: 0

  def bar_length(x) do

    percent = 100 * ((:math.log2(x) +1)/12)

    to_string(percent) <> "%"
  end

end
