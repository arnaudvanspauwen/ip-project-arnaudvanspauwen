defmodule ProjectR0713225Web.AnimalView do
  use ProjectR0713225Web, :view
  alias ProjectR0713225Web.AnimalView

  def render("index.json", %{animals: animals}) do
    %{data: render_many(animals, AnimalView, "getmyanimals.json")}
  end

  def render("show.json", %{animal: animal}) do
    %{data: render_one(animal, AnimalView, "getanimal.json")}
  end

  def render("getanimal.json", %{animal: animal}) do
    %{id: animal.id,
      name: animal.name,
      dob: animal.dob,
      cat_or_dog: animal.cat_or_dog}
  end

  def render("getmyanimals.json", %{animal: animal}) do
    %{id: animal.id,
      name: animal.name}
  end
end
