Rcity::Engine.routes.draw do
  
  resources :regions

  resources :provinces

  resources :countries


    match '/cities/:dir(/:code)'=>'cities#index',:as=>:citiesindex
   match '/cities/modal/show(/:code)/line/:fcode/:tcode'=>'cities#modal',:as=>:citiesmodal
   match '/cities/map/show/city/:code'=>'cities#mapcity',:as=>:citiesmapcity
   match '/cities/map/show/line/:fcode/:tcode'=>'cities#mapline',:as=>:citiesmapline
   
  resources :cities
end
