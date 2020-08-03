defmodule ProjectR0713225Web.Plugs.ApiKeyPlug do
    import Plug.Conn
    import ProjectR0713225Web.Gettext
    alias ProjectR0713225.UserContext.User
    alias ProjectR0713225.ApiKeyContext
    alias ProjectR0713225.UserContext
    alias Phoenix.Controller
    require Logger
  
    def init(options), do: options
  
    def call(%{req_headers: header, path_params: path_params} = conn, options) do
      user_id = String.to_integer(Map.get(path_params, "user_id"))
      {"myfancyheader", api_key} = header |> List.keyfind("myfancyheader", 0)
      
      
      access? = ApiKeyContext.key_correct?(user_id, api_key)
      canWrite?=ApiKeyContext.apiKey_canWrite?(user_id, api_key)
      readOnly?=conn.method=="GET"

      if readOnly? do
        conn
        |> grant_access(access?)
      else
        conn
        |> grant_access(access?)
        |> grant_access(canWrite?)
      end
    end
  
    def grant_access(conn, true), do: conn
  
    def grant_access(conn, false) do
      conn
      |> Plug.Conn.put_resp_header("content-type", "application/json; charset=utf-8")
      |> Plug.Conn.send_resp(200, gettext("Unauthorized access"))
    end

end