defmodule FreteValidateWeb.ValidateController do
  use FreteValidateWeb, :controller

  alias FreteValidate.Validates

  def create(conn, %{"cep" => cep, "price" => price}) do
    with {:ok, input_data} <- Validates.validate_input_file("input.json"),
         {:ok, cep} <- Validates.validate_cep(cep),
         initial_output <- Validates.init_output(input_data),
         output <- Validates.handle_input_data(cep, input_data, price, initial_output) do
      conn
      |> put_status(200)
      |> render("result.json", result: output)
    end
  end
end
