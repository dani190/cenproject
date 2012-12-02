Cencolproject::Application.routes.draw do
  devise_for :admin

  root :to => 'pages#index'
  
  match "/display" => "pages#display"
  match "/department_queue" => "pages#department_queue"
  match "/admin/students/view" => "admin/students#view"
  
  namespace :admin do
    root :to => 'main#index'
    resources :students
    resources :departments
    resources :queued_students
  end
  
  match "/404", :to => "errors#e404"
  match "/500", :to => "errors#e500"
  match "/422", :to => "errors#e422"
  
end
