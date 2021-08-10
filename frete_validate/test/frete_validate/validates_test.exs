defmodule FreteValidate.ValidatesTest do
  @moduledoc false
  use ExUnit.Case

  alias FreteValidate.Validates

  describe "validate_cep/1" do
    test "return a formatted cep if put correctly size" do
      input_cep = "14783-231"

      assert {:ok, formatted_cep} = Validates.validate_cep(input_cep)
      assert formatted_cep == "14783231"
    end

    test "return a error if put invalid cep size" do
      input_cep = "14783-23"

      assert {:error, :invalid_cep_size} = Validates.validate_cep(input_cep)
    end
  end

  describe "validate_input_file/0" do
    test "return input_file if is correctly" do
      expected_input_file = File.read!("input.json") |> Jason.decode!()

      {:ok, result_input_file} = Validates.validate_input_file("input.json")

      assert expected_input_file == result_input_file
    end

    test "return error if input file is incorrect" do
      assert {:error, :nonstandard_file} =
               Validates.validate_input_file("test/wrong_input_file.json")
    end
  end

  describe "init_output/1" do
    test "return initial output file correctly" do
      input_file = File.read!("input.json") |> Jason.decode!()

      expetcted_output_file =
        File.read!("test/initial_output.json")
        |> Jason.decode!()

      output_file_result = Validates.init_output(input_file)

      assert expetcted_output_file == output_file_result
    end
  end

  describe "handle_input_data/4" do
    test "return initial output file correctly" do
      input_file = File.read!("input.json") |> Jason.decode!()

      output_file =
        File.read!("test/initial_output.json")
        |> Jason.decode!()

      expected_output = File.read!("test/output.json") |> Jason.decode!()

      cep = "14783231"
      price = 1000

      output_result = Validates.handle_input_data(cep, input_file, price, output_file)

      assert expected_output == output_result
    end
  end
end
