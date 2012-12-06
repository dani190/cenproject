Cencolproject::Application.routes.draw do
  devise_for :admin

  root :to => 'pages#index'
  
  match "/display" => "pages#display"
  match "/admin/departments/queue" => "admin/departments#queue"
  match "/admin/students/view" => "admin/students#view"
  match "/queue" => "pages#queue"
  
  namespace :admin do
    root :to => 'departments#queue'
    resources :students
    resources :departments
    resources :queued_students
  end

end
