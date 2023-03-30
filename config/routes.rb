Rails.application.routes.draw do
  resources :issues do
    resources :comments, only: [:create, :destroy]
  end
  get 'issues/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'issues#index'
end
