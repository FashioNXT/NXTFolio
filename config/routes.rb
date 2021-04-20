Rails.application.routes.draw do
  #get 'template/create'
  #post 'template/create' => 'template#create', :as => 'template/create1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'general_info_list' => 'general_info#list', :as => 'general_info_list'
  get 'general_info_save' => 'general_info#save', :as => 'general_info_save'
  get 'general_info/edit' => 'general_info#edit', :as => 'general_info/edit'
  post 'general_info/update' => 'general_info#update', :as => 'general_info/update'
  get 'general_info/edit_profession' => 'general_info#edit_profession', :as => 'general_info/edit_profession'
  post 'general_info/update_profession' => 'general_info#update_profession', :as => 'general_info/update_profession'
  get 'general_info/profession_specific' => 'general_info#profession_specific', :as => 'general_info/profession_specific'
  post 'general_info/profession_specific' => 'general_info#profession_specific_create', :as => 'general_info/profession_specific_create'

  namespace :admin do
    get '/' => 'admin#landing'
    get '/create' => 'admin#create'
    post '/create' => 'admin#create'
    get '/edit' => 'admin#edit'
    post '/edit' => 'admin#edit'
    get '/delete' => 'admin#delete'
    post '/delete' => 'admin#delete'
  end

  get '/general_info/make_admin/:user' => 'general_info#make_admin' 
  
  get 'edit_job' => 'edit_job#edit'
  post 'edit_job' => 'edit_job#update'
  patch 'edit_job/update' => 'edit_job#update'
  post 'edit_job/update' => 'edit_job#update'
  get 'login_info_list' => 'login_info#list', :as => 'login_info_list'
  get 'login_info/login' => 'login_info#login', :as => 'login_info/login'
  post 'login_info/login_submit' => 'login_info#login_submit', :as => 'login_info/login_submit'
  # get 'login_info/logout' => 'login_info#logout', :as => 'login_info/logout'
  post 'login_info/create' => 'login_info#create', :as => 'login_info/create'
  get 'login_info/edit' => 'login_info#edit', :as => 'login_info/edit'
  post 'login_info/update' => 'login_info#update', :as => 'login_info/update'
  
  post 'login' => 'login_info#login', :as => 'login'
  get  'logout' => 'login_info#logout', :as => 'logout'
  # post 'create' => 'login_info#create', :as => 'create'


  get 'specific_designer_list' => 'specific_designer#list', :as => 'specific_designer_list'
  get 'specific_designer/edit' => 'specific_designer#edit', :as => 'specific_designer/edit'
  post 'specific_designer/update' => 'specific_designer#update', :as => 'specific_designer/update'
  
  get 'specific_model_list' => 'specific_model#list', :as => 'specific_model_list'
  get 'specific_model/edit' => 'specific_model#edit', :as => 'specific_model/edit'
  post 'specific_model/update' => 'specific_model#update', :as => 'specific_model/update'
  
  get 'specific_photographer_list' => 'specific_photographer#list', :as => 'specific_photographer_list'
  get 'specific_photographer/edit' => 'specific_photographer#edit', :as => 'specific_photographer/edit'
  post 'specific_photographer/update' => 'specific_photographer#update', :as => 'specific_photographer/update'
  
  get 'show_profile/mymodel' => 'show_profile#show_model', :as => 'show_profile_show_model'
  get 'show_profile' => 'show_profile#show_profile', :as => 'show_profile_show_profile'
  
  get 'search_profile/show' => 'search_profile#show', :as => 'search_profile/show'
  get 'search_profile/search' => 'search_profile#search', :as => 'search_profile/search'
  get 'search_profile/search_general' => 'search_profile#search_general', :as => 'search_profile/search_general'
  get 'search_profile/search_job' => 'search_profile#search_job', :as => 'search_profile/search_job'

  get 'search_profile/search_login' => 'search_profile#search_login', :as => 'search_profile/search_login'

  get 'search_profile/search_model' => 'search_profile#search_model', :as => 'search_profile/search_model'
  get 'search_profile/search_photographer' => 'search_profile#search_photographer', :as => 'search_profile/search_photographer'
  get 'search_profile/search_specific' => 'search_profile#search_specific', :as => 'search_profile/search_specific'
  get 'search_profile/search_specific_model' => 'search_profile#search_specific_model', :as => 'search_profile/search_specific_model'
  get 'search_profile/search_specific_photographer' => 'search_profile#search_specific_photographer', :as => 'search_profile/search_specific_photographer'
  get 'search_profile/show_profile/:id' => 'search_profile#show_profile', :as => 'search_profile/show_profile'
  get 'add_profession' => 'template#index', :as => 'template'
  post '/' => 'general_info#index', :as => 'general_info_index_post'
  resources :general_info
  resources :login_info
  resources :specific_designer
  resources :specific_model
  resources :specific_photographer
  resources :search_profile
  resources :template

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  root 'application#index'
end
