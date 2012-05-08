Rtruck::Engine.routes.draw do
  get "home/root"

  match "trucks/shownol/:id"=>"trucks#shownol", :via => :get,:as=>"truckswhownol"
  match "trucks/search" =>'trucks#search', :via => :get,:as=>"truckssearch"
  match "stock_trucks/concern" =>'stock_trucks#concern', :via => :get,:as=>"stock_trucks_concern"
  match "trucks/search/province/:province_id(/fcity/:fcity_id)(/tcity/:tcity_id)"  =>'trucks#search_province',:via => :get,:as=>"trucks_province_search"
  match "trucks/search/region/:region_id(/fcity/:fcity_id)(/tcity/:tcity_id)"  =>'trucks#search_region',:via => :get,:as=>"trucks_region_search"
  match "trucks/search/city/:cheng_id(/fcity/:fcity_id)(/tcity/:tcity_id)"  =>'trucks#search_cheng',:via => :get,:as=>"trucks_cheng_search"

  resources :stock_trucks do
    resources :trucks
  end

   resources :stock_trucks
   resources :trucks
   resources :truck_groups
     root :to => "trucks#search"
end
