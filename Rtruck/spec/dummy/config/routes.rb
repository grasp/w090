Rails.application.routes.draw do
  mount Rcity::Engine => "/rcity",:as=>"rcity"
  mount Ruser::Engine => "/ruser",:as=>"ruser"
  mount Rtruck::Engine => "/rtruck",:as=>"rtruck"
end
