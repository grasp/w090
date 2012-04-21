Rcargo::Engine.routes.draw do

      namespace :cpanel do 
     	resources :cargo_big_categories 

     end

  get "home/root"
  match 'cargo_categories/cargo_package' => 'cargo_categories#cargo_package', :via => :get
# get 'cargo_categories/cargo_package'
 root :to => "home#root"
  resources :stock_cargos do
     resources :cargos
  end
    resources :cargos

    resources :cargo_categories do 
    	get "nav"
    	
    end
    
#match 'cargo_categories/cargo_package'


end
