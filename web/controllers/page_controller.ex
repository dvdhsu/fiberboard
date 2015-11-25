defmodule Fiberboard.PageController do
  use Fiberboard.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
