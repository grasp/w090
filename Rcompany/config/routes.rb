Rcompany::Engine.routes.draw do
	
	get "home/root"
	match 'companies/yellowpage' =>'companies#yellowpage',:as=>:companiesneyellowpage
	root :to => "home#root"

	resources :companies
	end
