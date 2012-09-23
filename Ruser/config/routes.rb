Ruser::Engine.routes.draw do
 # get "admin/index"
 match "admin/index", :to => "admin#index"

  root :to => "users#routenav"

  devise_for :users, :path => "account", :class_name=>'Ruser::User',:controllers => {
      module: :devise,
      :registrations => "ruser/account",
      :sessions=>"ruser/rsessions",
      :passwords=>"ruser/rpasswords",
      :omniauth_callbacks => "ruser/user/omniauth_callbacks",
    } #do
   get "ruser/account/update_private_token" => "account#update_private_token", :as => :update_private_token_account
    #end
  
    match "account/auth/:provider/unbind", :to => "users#auth_unbind"

    match "users/location/:id", :to => "users#location", :as => :location_users
  
      resources :users       
      resources :users do
       member do
        get :topics
         get :likes
        # get :edit
        # get :new
       end
    end
    
    resources :notifications, :only => [:index, :destroy] do
    collection do
      put :mark_all_as_read
    end
  end
  end
