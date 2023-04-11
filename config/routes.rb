Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :issues
  resources :users
  get 'issues/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'issues#index'
end
