defmodule MagianToolsWeb.UserController do
  alias MagianTools.{Repo, User}
  use MagianToolsWeb, :controller

  def index(conn, _params) do
    render(conn, :index, users: Repo.all(User))
  end

  def create(conn, %{"username" => username,
      "email" => email,
      "password" => password}) do

    user = User.changeset(%User{}, %{
      username: username,
      email: email,
      password_digest: Bcrypt.hash_pwd_salt(password),
      session_token: Util.base64Random(Util.sessionTokenLength()),
      permission_level: 0
    })

    if user.valid? do
      delete_csrf_token()
      result = Repo.insert!(user)
      render(conn, :show, user: result, csrf: get_csrf_token())
    end
    resp(conn, 422, "")
  end
end
