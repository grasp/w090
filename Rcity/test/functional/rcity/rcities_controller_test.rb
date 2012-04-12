require 'test_helper'

module Rcity
  class RcitiesControllerTest < ActionController::TestCase
    setup do
      @rcity = rcities(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:rcities)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create rcity" do
      assert_difference('Rcity.count') do
        post :create, rcity: { address: @rcity.address, code: @rcity.code, coordinates: @rcity.coordinates, lat: @rcity.lat, lng: @rcity.lng, loc: @rcity.loc, name: @rcity.name }
      end
  
      assert_redirected_to rcity_path(assigns(:rcity))
    end
  
    test "should show rcity" do
      get :show, id: @rcity
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @rcity
      assert_response :success
    end
  
    test "should update rcity" do
      put :update, id: @rcity, rcity: { address: @rcity.address, code: @rcity.code, coordinates: @rcity.coordinates, lat: @rcity.lat, lng: @rcity.lng, loc: @rcity.loc, name: @rcity.name }
      assert_redirected_to rcity_path(assigns(:rcity))
    end
  
    test "should destroy rcity" do
      assert_difference('Rcity.count', -1) do
        delete :destroy, id: @rcity
      end
  
      assert_redirected_to rcities_path
    end
  end
end
