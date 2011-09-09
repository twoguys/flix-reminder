FlixReminder::Application.routes.draw do
    
  match '/auth/:provider/callback'  => 'users#create_or_login'
  match '/auth/failure'             => 'users#failure'
  match '/authorize_netflix'        => 'users#authorize_netflix'
    
  resources :users
  match '/settings'                 => 'users#settings'
  match '/logout'                   => 'users#logout'
  match '/send_email'               => 'users#send_email',    as: "send_email"

  match '/t/:token/adjust_queue'    => 'users#adjust_queue',  as: "adjust_queue"

  root :to => 'welcome#index'
end
