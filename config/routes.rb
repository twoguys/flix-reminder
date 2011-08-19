FlixReminder::Application.routes.draw do
    
  match '/auth/:provider/callback' => 'users#create'

  root :to => 'welcome#index'
  
end