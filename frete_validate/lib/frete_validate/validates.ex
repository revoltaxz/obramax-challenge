defmodule FreteValidate.Validates do
  @type output_list :: list()

  @doc """
    Validate parsed cep (cep without special characters)

    ## Example

    iex > validate_cep(%{"cep" => "14783-235"})
    "14783235"
  """

  @spec validate_cep(String.t()) :: {:ok, String.t()} | {:error, :invalid_cep_size}
  def validate_cep(cep) do
    cep_formatted = format_cep(cep)

    cond do
      String.length(cep_formatted) == 8 ->
        {:ok, cep_formatted}

      true ->
        {:error, :invalid_cep_size}
    end
  end

  @doc """
    Validate input file (.json)
  """

  @spec validate_input_file(String.t()) :: {:ok, list()} | {:error, :nonstandard_file}
  def validate_input_file(path) do
    default_keys = ["name", "active", "min_price_in_cents", "range_postcode_valid"]

    input_data =
      File.read!(path)
      |> Jason.decode!()

    input_data
    |> Enum.map(fn shipping_item ->
      Enum.all?(default_keys, fn key -> Map.has_key?(shipping_item, key) end)
    end)
    |> Enum.member?(false)
    |> case do
      true ->
        {:error, :nonstandard_file}

      false ->
        {:ok, input_data}
    end
  end

  @doc """
    Create a output data from loaded file (.json)
  """

  @spec init_output(list()) :: list()
  def init_output(input_data) do
    input_data
    |> Enum.reduce([], fn item, acc ->
      output =
        Map.new()
        |> Map.put("method", item["name"])
        |> Map.put("valid", true)
        |> Map.put("incompatibilities", [])

      [output | acc]
    end)
  end

  @doc """
    Handler with some validations to check shipping methoda and inserting
    incompatibilities if there are
  """

  @spec handle_input_data(String.t(), list(), integer(), list()) :: output_list()
  def handle_input_data(cep, input_list, price, output_list) do
    Enum.reduce(input_list, output_list, fn input_item, output_item ->
      validate_cep_range(cep, input_item, output_item)
      |> validate_price(input_item, price)
      |> validate_is_active(input_item)
    end)
  end

  @spec validate_cep_range(String.t(), map(), list()) :: output_list()
  defp validate_cep_range(cep, input_item, output_list) do
    [initial_zipcode | [last_zipcode]] = input_item["range_postcode_valid"]
    name = input_item["name"]

    if cep >= initial_zipcode and cep <= last_zipcode do
      output_list
    else
      Enum.map(output_list, fn
        %{"method" => method} = output_item when method == name ->
          update_output_item(:cep, output_item)

        output_item ->
          output_item
      end)
    end
  end

  @spec validate_is_active(list(), map()) :: output_list()
  defp validate_is_active(output_list, input_item) do
    %{"active" => active, "name" => name} = input_item

    if active do
      output_list
    else
      Enum.map(output_list, fn
        %{"method" => method} = output_item when method == name ->
          update_output_item(:active, output_item)

        output_item ->
          output_item
      end)
    end
  end

  @spec validate_price(list(), map(), integer()) :: output_list()
  defp validate_price(output_list, input_item, price) do
    name = input_item["name"]

    if price < input_item["min_price_in_cents"] do
      Enum.map(output_list, fn
        %{"method" => method} = output_item when method == name ->
          update_output_item(:price, output_item)

        output_item ->
          output_item
      end)
    else
      output_list
    end
  end

  defp update_output_item(:cep, output_item) do
    output_item
    |> Map.put("valid", false)
    |> Map.update(
      "incompatibilities",
      "Zip code outside the delivery area for this method",
      fn current_value ->
        ["Zip code outside the delivery area for this method" | current_value]
      end
    )
  end

  defp update_output_item(:active, output_item) do
    output_item
    |> Map.put("valid", false)
    |> Map.update(
      "incompatibilities",
      "Disabled shipping",
      fn current_value ->
        ["Disabled shipping" | current_value]
      end
    )
  end

  defp update_output_item(:price, output_item) do
    output_item
    |> Map.put("valid", false)
    |> Map.update(
      "incompatibilities",
      "Minimum price not reached for this method",
      fn current_value ->
        ["Minimum price not reached for this method" | current_value]
      end
    )
  end

  defp format_cep(cep) do
    cep
    |> String.split("-")
    |> Enum.join()
  end
end
