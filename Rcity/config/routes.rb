Rcity::Engine.routes.draw do





  #get "home/root"
  root :to => "home#root"

  
  #match '/cities/dir/:dir/code/(/:code)'=>'cities#index',:as=>:citiesindex
 # match '/cities/modal/show(/:code)/line/:fcode/:tcode'=>'cities#modal',:as=>:citiesmodal
 # match '/cities/map/show/city/:code'=>'cities#mapcity',:as=>:citiesmapcity
  #match '/cities/map/show/line/:fcode/:tcode'=>'cities#mapline',:as=>:citiesmapline
 


  resources :countries do 
    get "nav"
  end
 resources :provinces do 
    get "nav"
  end
  resources :regions do 
    get "nav"
  end

  resources :provinces do 
    get "nav"
  end

   resources :chengs do 
    get "nav"
    get "lineselect"
  end



end
