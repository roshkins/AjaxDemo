AjaxDemo::Application.routes.draw do
  root :to => "Users#new"

  resources :secrets
  resource :session
  resources :users
end
