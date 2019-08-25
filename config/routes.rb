Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#index'
  resources :user, only: [:new, :create, :show] do
    resources :vehicles, only: [:new, :create, :show]
  end
end
