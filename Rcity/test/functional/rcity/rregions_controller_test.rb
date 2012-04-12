require 'test_helper'

module Rcity
  class RregionsControllerTest < ActionController::TestCase
    setup do
      @rregion = rregions(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:rregions)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create rregion" do
      assert_difference('Rregion.count') do
        post :create, rregion: { address: @rregion.address, code: @rregion.code, coordinates: @rregion.coordinates, lat: @rregion.lat, lng: @rregion.lng, loc: @rregion.loc, name: @rregion.name }
      end
  
      assert_redirected_to rregion_path(assigns(:rregion))
    end
  
    test "should show rregion" do
      get :show, id: @rregion
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @rregion
      assert_response :success
    end
  
    test "should update rregion" do
      put :update, id: @rregion, rregion: { address: @rregion.address, code: @rregion.code, coordinates: @rregion.coordinates, lat: @rregion.lat, lng: @rregion.lng, loc: @rregion.loc, name: @rregion.name }
      assert_redirected_to rregion_path(assigns(:rregion))
    end
  
    test "should destroy rregion" do
      assert_difference('Rregion.count', -1) do
        delete :destroy, id: @rregion
      end
  
      assert_redirected_to rregions_path
    end
  end
end
