require 'test_helper'

module Rcity
  class RprovincesControllerTest < ActionController::TestCase
    setup do
      @rprovince = rprovinces(:one)
    end
  
    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:rprovinces)
    end
  
    test "should get new" do
      get :new
      assert_response :success
    end
  
    test "should create rprovince" do
      assert_difference('Rprovince.count') do
        post :create, rprovince: { address: @rprovince.address, code: @rprovince.code, coordinates: @rprovince.coordinates, lat: @rprovince.lat, lng: @rprovince.lng, loc: @rprovince.loc, name: @rprovince.name }
      end
  
      assert_redirected_to rprovince_path(assigns(:rprovince))
    end
  
    test "should show rprovince" do
      get :show, id: @rprovince
      assert_response :success
    end
  
    test "should get edit" do
      get :edit, id: @rprovince
      assert_response :success
    end
  
    test "should update rprovince" do
      put :update, id: @rprovince, rprovince: { address: @rprovince.address, code: @rprovince.code, coordinates: @rprovince.coordinates, lat: @rprovince.lat, lng: @rprovince.lng, loc: @rprovince.loc, name: @rprovince.name }
      assert_redirected_to rprovince_path(assigns(:rprovince))
    end
  
    test "should destroy rprovince" do
      assert_difference('Rprovince.count', -1) do
        delete :destroy, id: @rprovince
      end
  
      assert_redirected_to rprovinces_path
    end
  end
end
