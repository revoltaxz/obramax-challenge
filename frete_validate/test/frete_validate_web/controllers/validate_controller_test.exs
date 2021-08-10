defmodule FreteValidateWeb.ValidateControllerTest do
  use FreteValidateWeb.ConnCase

  describe "POST /validate" do
    test "returns 200 with valid data", %{conn: conn} do
      params = %{
        "cep" => "14783-235",
        "price" => 1000
      }

      expected_output = File.read!("test/output.json") |> Jason.decode!()

      result =
        post(conn, Routes.validate_path(conn, :create), params)
        |> json_response(200)

      assert expected_output == result
    end

    test "returns 400 with invalid data (invalid cep size)", %{conn: conn} do
      params = %{
        "cep" => "14783-23",
        "price" => 1000
      }

      result =
        post(conn, Routes.validate_path(conn, :create), params)
        |> json_response(400)

      assert result["status"] == "400"
      assert result["message"] == "You must insert cep correctly (11111-111 or 11111111)"
      assert result["title"] == "Invalid cep size"
    end
  end
end
