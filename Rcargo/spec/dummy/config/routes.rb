Rails.application.routes.draw do
  mount Rcity::Engine => "/rcity",:as=>"rcity"
  mount Ruser::Engine => "/ruser",:as=>"ruser"
  mount Rcargo::Engine => "/rcargo",:as=>"rcargo"
end
