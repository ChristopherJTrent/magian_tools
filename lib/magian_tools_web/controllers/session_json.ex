defmodule MagianToolsWeb.SessionJSON do
  alias MagianTools.User

  def show(%{user: user}) do
    %{user: data(user)}
  end

  defp data(%User{} = user) do
    %{
      username: user.username,
      email: user.email,
      session_token: user.session_token,
      permission_level: user.permission_level
    }
  end
end
