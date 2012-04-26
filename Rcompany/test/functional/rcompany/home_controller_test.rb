require 'test_helper'

module Rcompany
  class HomeControllerTest < ActionController::TestCase
    test "should get root" do
      get :root
      assert_response :success
    end
  
  end
end
