Rtruck::Engine.routes.draw do
  get "home/root"
  root :to => "home#root"
end
