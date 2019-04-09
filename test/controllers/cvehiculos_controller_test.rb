require 'test_helper'

class CvehiculosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cvehiculo = cvehiculos(:one)
  end

  test "should get index" do
    get cvehiculos_url
    assert_response :success
  end

  test "should get new" do
    get new_cvehiculo_url
    assert_response :success
  end

  test "should create cvehiculo" do
    assert_difference('Cvehiculo.count') do
      post cvehiculos_url, params: { cvehiculo: { activo: @cvehiculo.activo, descripcion: @cvehiculo.descripcion, titulo: @cvehiculo.titulo } }
    end

    assert_redirected_to cvehiculo_url(Cvehiculo.last)
  end

  test "should show cvehiculo" do
    get cvehiculo_url(@cvehiculo)
    assert_response :success
  end

  test "should get edit" do
    get edit_cvehiculo_url(@cvehiculo)
    assert_response :success
  end

  test "should update cvehiculo" do
    patch cvehiculo_url(@cvehiculo), params: { cvehiculo: { activo: @cvehiculo.activo, descripcion: @cvehiculo.descripcion, titulo: @cvehiculo.titulo } }
    assert_redirected_to cvehiculo_url(@cvehiculo)
  end

  test "should destroy cvehiculo" do
    assert_difference('Cvehiculo.count', -1) do
      delete cvehiculo_url(@cvehiculo)
    end

    assert_redirected_to cvehiculos_url
  end
end
