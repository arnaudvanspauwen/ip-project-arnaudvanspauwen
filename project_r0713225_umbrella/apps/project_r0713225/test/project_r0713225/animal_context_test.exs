defmodule ProjectR0713225.AnimalContextTest do
  use ProjectR0713225.DataCase

  alias ProjectR0713225.AnimalContext

  describe "animals" do
    alias ProjectR0713225.AnimalContext.Animal

    @valid_attrs %{cat_or_dog: "some cat_or_dog", dob: ~D[2010-04-17], name: "some name"}
    @update_attrs %{cat_or_dog: "some updated cat_or_dog", dob: ~D[2011-05-18], name: "some updated name"}
    @invalid_attrs %{cat_or_dog: nil, dob: nil, name: nil}

    def animal_fixture(attrs \\ %{}) do
      {:ok, animal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> AnimalContext.create_animal()

      animal
    end

    test "list_animals/0 returns all animals" do
      animal = animal_fixture()
      assert AnimalContext.list_animals() == [animal]
    end

    test "get_animal!/1 returns the animal with given id" do
      animal = animal_fixture()
      assert AnimalContext.get_animal!(animal.id) == animal
    end

    test "create_animal/1 with valid data creates a animal" do
      assert {:ok, %Animal{} = animal} = AnimalContext.create_animal(@valid_attrs)
      assert animal.cat_or_dog == "some cat_or_dog"
      assert animal.dob == ~D[2010-04-17]
      assert animal.name == "some name"
    end

    test "create_animal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AnimalContext.create_animal(@invalid_attrs)
    end

    test "update_animal/2 with valid data updates the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{} = animal} = AnimalContext.update_animal(animal, @update_attrs)
      assert animal.cat_or_dog == "some updated cat_or_dog"
      assert animal.dob == ~D[2011-05-18]
      assert animal.name == "some updated name"
    end

    test "update_animal/2 with invalid data returns error changeset" do
      animal = animal_fixture()
      assert {:error, %Ecto.Changeset{}} = AnimalContext.update_animal(animal, @invalid_attrs)
      assert animal == AnimalContext.get_animal!(animal.id)
    end

    test "delete_animal/1 deletes the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{}} = AnimalContext.delete_animal(animal)
      assert_raise Ecto.NoResultsError, fn -> AnimalContext.get_animal!(animal.id) end
    end

    test "change_animal/1 returns a animal changeset" do
      animal = animal_fixture()
      assert %Ecto.Changeset{} = AnimalContext.change_animal(animal)
    end
  end
end
