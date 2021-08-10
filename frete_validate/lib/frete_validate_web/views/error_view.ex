defmodule FreteValidateWeb.ErrorView do
  use FreteValidateWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("400.json", _assigns) do
    %{
      title: "Invalid cep size",
      status: "400",
      message: "You must insert cep correctly (11111-111 or 11111111)"
    }
  end

  def render("nonstardard_file.json", _assigns) do
    %{
      title: "Invalid file format",
      status: "400",
      message: "Your file is not a correct format"
    }
  end
end
