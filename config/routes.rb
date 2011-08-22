FlixReminder::Application.routes.draw do
    
  match '/auth/:provider/callback' => 'users#create_or_login'
  match '/auth/failure' => 'users#failure'

  root :to => 'welcome#index'
  devise_for :users
end