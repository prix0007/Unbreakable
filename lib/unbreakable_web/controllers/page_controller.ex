defmodule UnbreakableWeb.PageController do
  use UnbreakableWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
