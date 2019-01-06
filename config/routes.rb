Rails.application.routes.draw do
  get 'session/new'

 # get 'users/new'

  root 'static_page#home'

  get "help" => 'static_page#help'

  get "about"=>'static_page#about'

  get "signup" => "users#new"	
  
  get "login" =>"session#new"
  
  post "login" =>"session#create"
  
  delete "logout" =>"session#destroy"
	
	resources:users

  resources:blogs 
 
end
