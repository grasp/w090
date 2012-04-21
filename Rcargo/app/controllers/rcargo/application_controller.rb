module Rcargo
  class ApplicationController < ActionController::Base
    #layout "rtheme/rcargo"
    layout "rcargo"
   include  ApplicationControllerCommon
  end
end
