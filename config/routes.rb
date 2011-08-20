FlixReminder::Application.routes.draw do
    
  match '/auth/:provider/callback' => 'users#create'
  match '/auth/failure' => 'users#failure'

  root :to => 'welcome#index'
  
end