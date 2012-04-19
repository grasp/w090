Rcargo::Engine.routes.draw do

  get "home/root"
 root :to => "home#root"
    resources :cargos
	resources :stock_cargos
    resources :cargo_categories
    
end
