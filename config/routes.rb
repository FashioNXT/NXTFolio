Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :general_info
  resources :login_info
  resources :specific_designer
  resources :specific_model
  resources :specific_photographer
  
  get 'general_info_list' => 'general_info#list', :as => 'general_info_list'
  get 'login_info_list' => 'login_info#list', :as => 'login_info_list'
  get 'specific_designer_list' => 'specific_designer#list', :as => 'specific_designer_list'
  get 'specific_model_list' => 'specific_model#list', :as => 'specific_model_list'
  get 'specific_photographer' => 'specific_photographer#list', :as => 'specific_photographer_list'
  
end
