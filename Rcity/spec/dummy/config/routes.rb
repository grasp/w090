Rails.application.routes.draw do
  mount Rcity::Engine => "/rcity",:as=>"rcity"
end
