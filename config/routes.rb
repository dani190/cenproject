Cencolproject::Application.routes.draw do
  devise_for :admin

  root :to => 'pages#index'
  
  match "/display" => "pages#display"
  
  namespace :admin do
    root :to => 'main#index'
    resources :students
    resources :departments
  end
  
  match "/404", :to => "errors#e404"
  match "/500", :to => "errors#e500"
  match "/422", :to => "errors#e422"
  
end
