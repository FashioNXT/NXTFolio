Rails.application.routes.draw do

  get 'search_profile/search'

  get 'search_profile/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'general_info_list' => 'general_info#list', :as => 'general_info_list'
  get 'general_info_save' => 'general_info#save', :as => 'general_info_save'
  get 'general_info/search' => 'general_info#search', :as => 'general_info/search'
  get 'general_info/search_redirect' => 'general_info#search_redirect', :as => 'general_info/search_redirect'
  post 'general_info_select_next' => 'general_info#select_next', :as => 'general_info_select_next'
  
  get 'login_info_list' => 'login_info#list', :as => 'login_info_list'
  get 'login_info/login' => 'login_info#login', :as => 'login_info/login'
  post 'login_info/login_submit' => 'login_info#login_submit', :as => 'login_info/login_submit'
  get 'login_info/logout' => 'login_info#logout', :as => 'login_info/logout'
  
  get 'specific_designer/search' => 'specific_designer#search', :as => 'specific_designer/search'
  get 'specific_designer_list' => 'specific_designer#list', :as => 'specific_designer_list'
  get 'specific_designer/search_redirect' => 'specific_designer#search_redirect', :as => 'specific_designer/search_redirect'
  
  get 'specific_model/search' => 'specific_model#search', :as => 'specific_model/search'
  get 'specific_model_list' => 'specific_model#list', :as => 'specific_model_list'
  get 'specific_model/search_redirect' => 'specific_model#search_redirect', :as => 'specific_model/search_redirect'
  
  get 'specific_photographer/search' => 'specific_photographer#search', :as => 'specific_photographer/search'
  get 'specific_photographer_list' => 'specific_photographer#list', :as => 'specific_photographer_list'
  get 'specific_photographer/search_redirect' => 'specific_photographer#search_redirect', :as => 'specific_photographer/search_redirect'
  
  get 'show_profile/mymodel' => 'show_profile#show_model', :as => 'show_profile_show_model'
  get 'show_profile' => 'show_profile#show_profile', :as => 'show_profile_show_profile'
  
  resources :general_info
  resources :login_info
  resources :specific_designer
  resources :specific_model
  resources :specific_photographer
  resources :search_profile
  
  root 'application#index'
end
