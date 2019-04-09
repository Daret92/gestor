require "application_system_test_case"

class CvehiculosTest < ApplicationSystemTestCase
  setup do
    @cvehiculo = cvehiculos(:one)
  end

  test "visiting the index" do
    visit cvehiculos_url
    assert_selector "h1", text: "Cvehiculos"
  end

  test "creating a Cvehiculo" do
    visit cvehiculos_url
    click_on "New Cvehiculo"

    fill_in "Activo", with: @cvehiculo.activo
    fill_in "Descripcion", with: @cvehiculo.descripcion
    fill_in "Titulo", with: @cvehiculo.titulo
    click_on "Create Cvehiculo"

    assert_text "Cvehiculo was successfully created"
    click_on "Back"
  end

  test "updating a Cvehiculo" do
    visit cvehiculos_url
    click_on "Edit", match: :first

    fill_in "Activo", with: @cvehiculo.activo
    fill_in "Descripcion", with: @cvehiculo.descripcion
    fill_in "Titulo", with: @cvehiculo.titulo
    click_on "Update Cvehiculo"

    assert_text "Cvehiculo was successfully updated"
    click_on "Back"
  end

  test "destroying a Cvehiculo" do
    visit cvehiculos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cvehiculo was successfully destroyed"
  end
end
