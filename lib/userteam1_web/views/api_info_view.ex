defmodule Userteam1Web.ApiInfoView do
  use Userteam1Web, :view

  def render("info.json", %{info: info}) do
    %{
      content:
        if info == nil do
          "no info set"
        else
          info.content
        end
    }
  end
end
