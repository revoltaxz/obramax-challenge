defmodule FreteValidateWeb.ValidateView do
  use FreteValidateWeb, :view

  def render("result.json", %{result: result}) do
    result
  end
end
