Rforum::Engine.routes.draw do
  
  root :to => "rforum#nodenav"
  # require 'api'

  
  resources :sites

  resources :posts
  resources :pages, :path => "wiki" do
    collection do
      get :recent
    end
  end
  resources :comments
  resources :notes
  
  match "/uploads/*path" => "gridfs#serve"
  
  #  resources :users do
  #  member do
  #   get :topics
  #  get :likes
  #  end
  # end
  
  resources :notifications, :only => [:index, :destroy] do
    collection do
      put :mark_all_as_read
    end
  end

  resources :nodes

  match "topics/node:id" => "topics#node", :as => :node_topics
  match "topics/node:id/feed" => "topics#node_feed", :as => :feed_node_topics
  match "topics/last" => "topics#recent", :as => :recent_topics
  resources :topics do
    member do
      post :reply
    end
    
    collection do
      get :search
      get :feed
      post :preview
    end
    resources :replies
  end

  resources :photos do
    collection do
      get :tiny_new
    end
  end
  resources :likes

  match "/search" => "search#index", :as => :search
  match "/search/topics" => "search#topics", :as => :search_topics
  match "/search/wiki" => "search#wiki", :as => :search_wiki

  namespace :cpanel do
    root :to => "home#index"
    resources :site_configs
    resources :replies
    resources :topics do
      member do
        post :suggest
        post :unsuggest
        post :undestroy
      end
    end
    resources :nodes
    resources :sections
    resources :users
    resources :photos
    resources :posts
    resources :pages do
      resources :versions, :controller => :page_versions do
        member do
          post :revert
        end
      end
    end
    resources :comments
    resources :site_nodes
    resources :sites
    resources :locations
  end
  #mount RubyChina::API => "/"

  # if Rails.env.development?
  #mount UserMailer::Preview => 'mails/user'
  # end
 
  #add for rforum debug
  match "rforum/topicnav" => "rforum#topicnav"
  match "rforum/routenav" => "rforum#routenav"
  match "rforum/nodenav" => "rforum#nodenav"
  match "rforum/cpanelnav" => "rforum#cpanelnav"
end


