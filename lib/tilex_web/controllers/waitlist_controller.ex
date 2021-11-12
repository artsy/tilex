defmodule TilexWeb.WaitlistController do
  use TilexWeb, :controller
  alias Tilex.CommunityUser

  def index(conn, _params) do
    changeset = CommunityUser.changeset(%CommunityUser{})

    conn
    |> assign(:changeset, changeset)
    |> render("index.html")
  end

  def create(conn, %{"community_user" => params}) do
    changeset = CommunityUser.changeset(%CommunityUser{}, params)

    case Repo.insert(changeset) do
      {:ok, _community_user} ->
        conn
        |> put_flash(:info, "You've joined the waiting list!")
        |> redirect(to: post_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("index.html")
    end
  end
end
