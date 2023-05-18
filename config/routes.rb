Rails.application.routes.draw do

  get '/issues/:id/comments', to: 'comments#index'
  get '/issues/:id/watchers', to: 'issues#get_watchers'
  post '/issues/:id/addwatchers', to: 'issues#add_watchers'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :issues do
    resources :comments
    member do
      post 'add_watcher', action: :add_watcher
      post 'add_watchers', action: :add_watchers
      delete 'remove_watcher/:user_id', action: :remove_watcher, as: 'remove_watcher'
    end
  end
  resources :users
  get 'issues/index'
  post 'issues/create_issues_bulk'
  post 'issues/bulk_insert', to: 'issues#create_issues_bulk'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'issues#index'

  #put '/issues/:id/delete_attachment' => "issues#delete_attachment", as: :delete_attachment

  resources :issues do
    resources :arxius, only: [:create, :destroy]
  end

end