defmodule FreteValidateWeb.FallbackController do
  use FreteValidateWeb, :controller

  def call(conn, {:error, :invalid_cep_size}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FreteValidateWeb.ErrorView)
    |> render("400.json")
  end

  def call(conn, {:error, :nonstandard_file}) do
    conn
    |> put_status(:bad_request)
    |> put_view(FreteValidateWeb.ErrorView)
    |> render("nonstardard_file.json")
  end
end
