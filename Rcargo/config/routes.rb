Rcargo::Engine.routes.draw do

      namespace :cpanel do 
     	resources :cargo_big_categories 

     end

  get "home/root"
 root :to => "home#root"
    resources :cargos
	resources :stock_cargos
    resources :cargo_categories do 
    	get "nav"
    end
    

end
