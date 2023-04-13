Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :issues do
    resources :comments
  end
  resources :users
  get 'issues/index'
  post 'issues/create_issues_bulk'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'issues#index'
end
