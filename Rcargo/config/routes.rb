Rcargo::Engine.routes.draw do

	resources :cargos
	resources :stock_cargos
    resources :cargo_categories
end
