require 'test_helper'

module Rcity
  class RcountriesControllerTest < ActionController::TestCase
    setup do
      @rcountry = rcountries(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:rcountries)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create rcountry" do
      assert_difference('Rcountry.count') do
        post :create, rcountry: { address: @rcountry.address, code: @rcountry.code, coordinates: @rcountry.coordinates, lat: @rcountry.lat, lng: @rcountry.lng, loc: @rcountry.loc, name: @rcountry.name }
      end
  
      assert_redirected_to rcountry_path(assigns(:rcountry))
    end
  
    test "should show rcountry" do
      get :show, id: @rcountry
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @rcountry
      assert_response :success
    end
  
    test "should update rcountry" do
      put :update, id: @rcountry, rcountry: { address: @rcountry.address, code: @rcountry.code, coordinates: @rcountry.coordinates, lat: @rcountry.lat, lng: @rcountry.lng, loc: @rcountry.loc, name: @rcountry.name }
      assert_redirected_to rcountry_path(assigns(:rcountry))
    end
  
    test "should destroy rcountry" do
      assert_difference('Rcountry.count', -1) do
        delete :destroy, id: @rcountry
      end
  
      assert_redirected_to rcountries_path
    end
  end
end
