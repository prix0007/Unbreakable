defmodule UnbreakableWeb.GoalView do
  use UnbreakableWeb, :view

  alias Unbreakable.Core.{Goal, Streak}

  def bar_css(0), do: "width: 0; display: hidden;"

  def bar_css(x) do
    percent = 100 * ((:math.log2(x) +1)/12)
    "width: " <> to_string(percent) <> "%"
  end

  def make_bar(goal) do
    goal
    |> get_current_streak()
    |> bar_css()
  end

  def get_current_streak(%Goal{streaks: []}), do: 0
  def get_current_streak(goal) do
    today = Date.utc_today()
    case (hd goal.streaks) do
      %Streak{end: ^today, length: len} -> len
      _ -> 0
    end
  end

end
