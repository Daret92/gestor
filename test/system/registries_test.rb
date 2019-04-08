require "application_system_test_case"

class RegistriesTest < ApplicationSystemTestCase
  setup do
    @registry = registries(:one)
  end

  test "visiting the index" do
    visit registries_url
    assert_selector "h1", text: "Registries"
  end

  test "creating a Registry" do
    visit registries_url
    click_on "New Registry"

    fill_in "Descripcion", with: @registry.descripcion
    fill_in "Finalizado", with: @registry.finalizado
    fill_in "Proyecto", with: @registry.proyecto_id
    fill_in "Resultado", with: @registry.resultado
    fill_in "Titulo", with: @registry.titulo
    fill_in "User", with: @registry.user_id
    click_on "Create Registry"

    assert_text "Registry was successfully created"
    click_on "Back"
  end

  test "updating a Registry" do
    visit registries_url
    click_on "Edit", match: :first

    fill_in "Descripcion", with: @registry.descripcion
    fill_in "Finalizado", with: @registry.finalizado
    fill_in "Proyecto", with: @registry.proyecto_id
    fill_in "Resultado", with: @registry.resultado
    fill_in "Titulo", with: @registry.titulo
    fill_in "User", with: @registry.user_id
    click_on "Update Registry"

    assert_text "Registry was successfully updated"
    click_on "Back"
  end

  test "destroying a Registry" do
    visit registries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Registry was successfully destroyed"
  end
end
