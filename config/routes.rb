AjaxDemo::Application.routes.draw do
  root :to => "secrets#index"

  resources :secrets
  resources :users
end
