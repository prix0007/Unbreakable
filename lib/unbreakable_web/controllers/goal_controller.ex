defmodule UnbreakableWeb.GoalController do
  use UnbreakableWeb, :controller

  alias Unbreakable.Core
  alias Unbreakable.Core.Goal

  def index(conn, _params) do
    goals = Core.list_goals()
    render(conn, "index.html", goals: goals)
  end
end
