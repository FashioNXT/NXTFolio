Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'general_info_list' => 'general_info#list', :as => 'general_info_list'
  get 'general_info_save' => 'general_info#save', :as => 'general_info_save'
  #get 'general_info/search' => 'general_info#search', :as => 'general_info/search'
  #get 'general_info/search_redirect' => 'general_info#search_redirect', :as => 'general_info/search_redirect'
  get 'general_info/edit' => 'general_info#edit', :as => 'general_info/edit'
  post 'general_info/update' => 'general_info#update', :as => 'general_info/update'
  get 'general_info/edit_profession' => 'general_info#edit_profession', :as => 'general_info/edit_profession'
  post 'general_info/update_profession' => 'general_info#update_profession', :as => 'general_info/update_profession'
  
  get 'login_info_list' => 'login_info#list', :as => 'login_info_list'
  get 'login_info/login' => 'login_info#login', :as => 'login_info/login'
  post 'login_info/login_submit' => 'login_info#login_submit', :as => 'login_info/login_submit'
  get 'login_info/logout' => 'login_info#logout', :as => 'login_info/logout'
  get 'login_info/edit' => 'login_info#edit', :as => 'login_info/edit'
  post 'login_info/update' => 'login_info#update', :as => 'login_info/update'
  
  #get 'specific_designer/search' => 'specific_designer#search', :as => 'specific_designer/search'
  get 'specific_designer_list' => 'specific_designer#list', :as => 'specific_designer_list'
  #get 'specific_designer/search_redirect' => 'specific_designer#search_redirect', :as => 'specific_designer/search_redirect'
  get 'specific_designer/edit' => 'specific_designer#edit', :as => 'specific_designer/edit'
  post 'specific_designer/update' => 'specific_designer#update', :as => 'specific_designer/update'
  
  #get 'specific_model/search' => 'specific_model#search', :as => 'specific_model/search'
  get 'specific_model_list' => 'specific_model#list', :as => 'specific_model_list'
  #get 'specific_model/search_redirect' => 'specific_model#search_redirect', :as => 'specific_model/search_redirect'
  get 'specific_model/edit' => 'specific_model#edit', :as => 'specific_model/edit'
  post 'specific_model/update' => 'specific_model#update', :as => 'specific_model/update'
  
  #get 'specific_photographer/search' => 'specific_photographer#search', :as => 'specific_photographer/search'
  get 'specific_photographer_list' => 'specific_photographer#list', :as => 'specific_photographer_list'
  #get 'specific_photographer/search_redirect' => 'specific_photographer#search_redirect', :as => 'specific_photographer/search_redirect'
  get 'specific_photographer/edit' => 'specific_photographer#edit', :as => 'specific_photographer/edit'
  post 'specific_photographer/update' => 'specific_photographer#update', :as => 'specific_photographer/update'
  
  get 'show_profile/mymodel' => 'show_profile#show_model', :as => 'show_profile_show_model'
  get 'show_profile' => 'show_profile#show_profile', :as => 'show_profile_show_profile'
  
  get 'search_profile/show' => 'search_profile#show', :as => 'search_profile/show'
  get 'search_profile/search' => 'search_profile#search', :as => 'search_profile/search'
  get 'search_profile/search_general' => 'search_profile#search_general', :as => 'search_profile/search_general'
  get 'search_profile/search_designer' => 'search_profile#search_designer', :as => 'search_profile/search_designer'
  get 'search_profile/search_model' => 'search_profile#search_model', :as => 'search_profile/search_model'
  get 'search_profile/search_photographer' => 'search_profile#search_photographer', :as => 'search_profile/search_photographer'
  get 'search_profile/search_specific_designer' => 'search_profile#search_specific_designer', :as => 'search_profile/search_specific_designer'
  get 'search_profile/search_specific_model' => 'search_profile#search_specific_model', :as => 'search_profile/search_specific_model'
  get 'search_profile/search_specific_photographer' => 'search_profile#search_specific_photographer', :as => 'search_profile/search_specific_photographer'
  get 'search_profile/show_profile/:id' => 'search_profile#show_profile', :as => 'search_profile/show_profile'
  
  resources :general_info
  resources :login_info
  resources :specific_designer
  resources :specific_model
  resources :specific_photographer
  resources :search_profile
  
  root 'application#index'
end
