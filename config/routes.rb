AjaxDemo::Application.routes.draw do
  get "friendships/create"

  root :to => "Users#new"

  resources :secrets, :except => [:new]
  resource :session
  resources :users do
    resources :secrets, :only => [:new]
    resource :friendship, :only => [:create, :destroy]
  end
end
