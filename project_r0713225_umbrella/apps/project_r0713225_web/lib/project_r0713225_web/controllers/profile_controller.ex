defmodule ProjectR0713225Web.ProfileController do
  use ProjectR0713225Web, :controller

    alias ProjectR0713225.ApiKeyContext
    alias ProjectR0713225.ApiKeyContext.ApiKey
    alias ProjectR0713225.UserContext
    alias ProjectR0713225.UserContext.User
    alias ProjectR0713225Web.Guardian

    def show_profile(conn, _) do
      user = Guardian.Plug.current_resource(conn)
      loadapis = ApiKeyContext.load_api_keys(user)
      changeset = ApiKeyContext.change_api_key(%ApiKey{})
      render(conn, "profile.html", user: user, apikeys: loadapis.apikeys, changeset: changeset)
    end

    def change_user(conn, _params) do
        user = Guardian.Plug.current_resource(conn)
        changeset = UserContext.change_user(user)
        render(conn, "changeusername.html", user: user, changeset: changeset, action: Routes.profile_path(conn, :change_user_post))
    end


    def change_user_post(conn, %{"user" => user_params}) do
        user = Guardian.Plug.current_resource(conn)
        case UserContext.update_user_username(user, user_params) do
            {:ok, user} ->
            conn
                |> put_flash(:info, gettext("Username changed successfully."))
                |> redirect(to: Routes.profile_path(conn, :show_profile))

            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "changeusername.html", user: user, changeset: changeset, action: Routes.profile_path(conn, :change_user_post))
        end
    end


    def change_password(conn, _params) do
        user = Guardian.Plug.current_resource(conn)
        changeset = UserContext.change_user(user)
        render(conn, "resetpassword.html", user: user, changeset: changeset, action: Routes.profile_path(conn, :change_password_post))
    end


    def change_password_post(conn, %{"user" => user_params}) do
        user = Guardian.Plug.current_resource(conn)
        case UserContext.update_user_password(user, user_params) do
            {:ok, user} ->
            conn
                |> put_flash(:info, gettext("Password changed successfully."))
                |> redirect(to: Routes.profile_path(conn, :show_profile))

            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "resetpassword.html", user: user, changeset: changeset, action: Routes.profile_path(conn, :change_password_post))
        end
    end

    def update_password(conn, %{"user" => user_params}) do
        user = Guardian.Plug.current_resource(conn)
        case UserContext.update_password(user, user_params) do
            {:ok, user}->
            conn
                |> put_flash(:info, "Password updated successfully.")
                |> redirect(to: Routes.user_path(conn, :profile))

            {:error, %Ecto.Changeset{} = changeset, error_msg} ->
                render(conn, "change_password.html", user: user, changeset: changeset, error_msg: error_msg)
        end
    end

    def create_api_key(conn, %{"api_key" => api_key_params}) do
        user = Guardian.Plug.current_resource(conn)
        case ApiKeyContext.create_api_key(api_key_params, user) do
            {:ok, %ApiKey{} = api_key }  ->
            conn
                |> put_flash(:info, "Key generated succesfully.")
                |> redirect(to: Routes.profile_path(conn, :show_profile))

            {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "profile.html", changeset: changeset, user: user)
        end
    end

    def showkey(conn, %{"id" => id}) do
        user = Guardian.Plug.current_resource(conn)
        api_key = 

        case ApiKeyContext.check_if_key_is_from_user!(id, user) do
        {:ok, api_key} ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.send_resp(200, api_key.key)

        {:unauthorized} ->
        conn
        |> put_flash(:error, "Unauthorized access")
        |> redirect(to: Routes.profile_path(conn, :show_profile))
        |> halt
        end
    end

    def deletekey(conn, %{"id" => id}) do
        user = Guardian.Plug.current_resource(conn)
        api_key = ApiKeyContext.get_api_key!(id,user)
        
        case ApiKeyContext.delete_api_key(api_key,user) do
        {:ok, _api_key} -> 
        conn
        |> put_flash(:info, "Key deleted successfully.")
        |> redirect(to: Routes.profile_path(conn, :show_profile))

        {:unauthorized} ->
        conn
        |> put_flash(:error, "Not your key")
        |> redirect(to: "/profile")
        |> halt
        end
    end

end