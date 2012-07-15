Rcompany::Engine.routes.draw do
	
	get "home/root"
	#match 'companies/yellowpage' =>'companies#yellowpage',:as=>:companiesneyellowpage
	match "companies/search" =>'companies#search', :via => :get,:as=>"companiessearch"
    match "companies/search/province/:province_id"  =>'companies#search_province',:via => :get,:as=>"companies_province_search"
    match "companies/search/region/:region_id"  =>'companies#search_region',:via => :get,:as=>"companies_region_search"
    match "companies/search/city/:cheng_id"  =>'companies#search_cheng',:via => :get,:as=>"companies_cheng_search"

	#root :to => "home#root"
	root :to => "companies#search"
	resources :companies
	end
