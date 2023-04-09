Rails.application.routes.draw do
  resources :issues
  get 'issues/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'issues#index'

  put '/issues/:id/delete_attachment' => "issues#delete_attachment", as: :delete_attachment

end