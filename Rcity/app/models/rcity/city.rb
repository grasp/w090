# coding: utf-8
class Rcity::City
  include Mongoid::Document
  include Mongoid::Timestamps 
  
  field :name, :type=>String
  field :code, :type=>String
  
  field :lat, :type=>Float
  field :lng, :type=>Float
  field :coordinates, :type => Array
  field :loc, :type => Array
  field :address

  
      def gmaps4rails_infowindow
      # add here whatever html content you desire, it will be displayed when users clicks on the marker
       "this is a test #{code},#{name}"
    end

end
