Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :exceptions
  end
end
