Rails.application.routes.draw do

  mount Rforum::Engine => "/rforum"
 mount Ruser::Engine => "/ruser"
end
