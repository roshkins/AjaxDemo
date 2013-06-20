AjaxDemo::Application.routes.draw do
  root :to => "Users#new"

  resources :secrets
  resources :users
end
