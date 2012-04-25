Rcargo::Engine.routes.draw do

      namespace :cpanel do 
     	resources :cargo_big_categories 

     end

  get "home/root"
  match 'cargo_categories/cargo_package' => 'cargo_categories#cargo_package', :via => :get
  match "cargos/search" =>'cargos#search', :via => :get,:as=>"cargossearch"
  match "cargos/search/province/:province_id(/fcity/:fcity_id)(/tcity/:tcity_id)"  =>'cargos#search_province',:via => :get,:as=>"cargos_province_search"
  match "cargos/search/region/:region_id(/fcity/:fcity_id)(/tcity/:tcity_id)"  =>'cargos#search_region',:via => :get,:as=>"cargos_region_search"
  match "cargos/search/city/:cheng_id(/fcity/:fcity_id)(/tcity/:tcity_id)"  =>'cargos#search_cheng',:via => :get,:as=>"cargos_cheng_search"

# get 'cargo_categories/cargo_package'

  resources :stock_cargos do
    resources :cargos
  end

  resources :cargos do
  # get "allcity"
  end
  
  resources :cargo_categories do 
    get "nav"  
  end

 root :to => "home#root"

end
