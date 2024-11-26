Rails.application.routes.draw do
  get 'general_info/:id/profile', to: 'general_info#profile', as: 'profile'
  # to retrive states and cities
  get 'messages', to: 'room#index'
  get 'states/:country_id', to: 'states#index', as: 'states'
  get 'cities/:state_id', to: 'cities#index', as: 'cities'
  post 'general_info/generate_about_me', to: 'general_info#generate_about_me', as: :generate_about_me

  post '/dm/:id', to: 'room#create_message'

  get '/dm', to: 'room#show'

  get '/dm/:id', to: 'room#show'

  get 'galleries/new' => 'galleries#new', :as => 'galleries/newg'

  get 'galleries/private_info/:id' => 'galleries#private_info'

  #get 'galleries/create'

  get 'galleries/destroy/:id'=> 'galleries#destroy', :as => 'galleries_destroy'

  get 'show_profile/destroy/:id'=> 'show_profile#destroy', :as => 'show_profile_destroy'

  get 'galleries/delete/:id'=> 'galleries#delete', :as => 'galleries_delete'

  get 'galleries/index'

  get 'galleries/show' => 'galleries#show', :as => 'galleries/show'

  post 'galleries/update' => 'galleries#update', :as => 'galleries/update'

  post 'galleries/create' => 'galleries#create', :as => 'galleries/create'

  # NXTFolio : Added in Spring 2023 for tagging feature
  post '/galleries/:id/create_tagging', to: 'galleries#create_tagging', as: 'create_tagging_gallery'
  delete '/galleries/:id/destroy_tagging', to: 'galleries#destroy_tagging', as: 'destroy_tagging_gallery'

  # spring2023 add/delete images in gallery
  get '/galleries/:id/edit', to: 'galleries#edit', as: 'edit_gallery'
  get '/galleries/:id/show', to: 'galleries#show', as: 'gallery'

  put '/galleries/:id/show', to: 'galleries#update', as: 'gallery/update'


  get '/galleries/:id/delete/:idx', to: 'galleries#delete', as: 'gallery_delete'

  get '/galleries/:id/add_images', to: 'galleries#transfer', as: 'gallery_added_image'

  # Fall 2023: To add comments
  get '/galleries/:id/comments', to: 'galleries#add_comment', as: 'gallery_add_comment'
  post '/galleries/:id/comments', to: 'galleries#post_comment', as: 'gallery_post_comment'

  # Winter 2024: To add tags
  get '/galleries/:id/tags', to: 'galleries#add_tag', as: 'gallery_add_tag'
  post '/galleries/:id/tags', to: 'galleries#create_tag', as: 'gallery_create_tag'

  #get 'template/create'
  #post 'template/create' => 'template#create', :as => 'template/create1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks",
                                   registrations: "users/registrations",
                                   sessions: "devise/sessions" }, 
                    skip: [:registrations] 
  get 'general_info_list' => 'general_info#list', :as => 'general_info_list'
  get 'general_info_save' => 'general_info#save', :as => 'general_info_save'
  get 'general_info/edit' => 'general_info#edit', :as => 'general_info/edit'
  get 'general_info/edit2' => 'general_info#edit2', :as => 'general_info/edit2'
  get 'general_info/edit_travel' => 'general_info#edit_travel', :as => 'general_info/edit_travel'
  get 'general_info/new', to: 'general_info#new', as: 'general_info_new'
  get 'general_info/new2' => 'general_info#new2', :as => 'general_info/new2'
  post 'general_info/update' => 'general_info#update', :as => 'general_info/update'
  get 'general_info/edit_profession' => 'general_info#edit_profession', :as => 'general_info/edit_profession'
  post 'general_info/update_profession' => 'general_info#update_profession', :as => 'general_info/update_profession'
  get 'general_info/profession_specific' => 'general_info#profession_specific', :as => 'general_info/profession_specific'
  post 'general_info/profession_specific' => 'general_info#profession_specific_create', :as => 'general_info/profession_specific_create'
  # Follow Feature
  get 'general_info/follow/:id' => 'general_info#follow'
  get 'general_info/unfollow/:id' => 'general_info#unfollow'

  namespace :admin do
    get '/' => 'admin#landing'
    get '/create' => 'admin#create'
    post '/create' => 'admin#create'
    get '/edit' => 'admin#edit'
    post '/edit' => 'admin#edit'  
    get '/delete' => 'admin#delete'
    post '/delete' => 'admin#delete'
  end

  namespace :api do
    get 'users', to: 'general_info#index'
    get 'delete/:id', to: 'general_info#delete'
    get 'toggle_access/:id', to: 'general_info#toggle_access'
    # resources :general_info, only: [:index]
  end

  get '/general_info/make_admin/:user' => 'general_info#make_admin'

  get 'edit_job' => 'edit_job#edit'
  post 'edit_job' => 'edit_job#update'
  patch 'edit_job/update' => 'edit_job#update'
  post 'edit_job/update' => 'edit_job#update'
  get 'login_info_list' => 'login_info#list', :as => 'login_info_list'
  get 'login_info/login' => 'login_info#login', :as => 'login_info/login'
  post 'login_info/login_submit' => 'login_info#login_submit', :as => 'login_info/login_submit'
  get 'login_info/logout' => 'login_info#logout', :as => 'login_info/logout'
  post 'login_info/new' => 'login_info#new', :as => 'login_info/new'
  post 'login_info/create' => 'login_info#create', :as => 'login_info/create'
  get 'login_info/edit' => 'login_info#edit', :as => 'login_info/edit'
  post 'login_info/update' => 'login_info#update', :as => 'login_info/update'
  get 'unconfirmed_user/new' => 'unconfirmed_user#new', :as => 'unconfirmed_user/new'
  post 'unconfirmed_user/verify' => 'unconfirmed_user#verify', :as => 'unconfirmed_user/verify'
  get 'unconfirmed_user/regenerate_token' => 'unconfirmed_user#regenerate_token', :as => 'unconfirmed_user/regenerate_token'


  get 'login' => 'login_info#login', :as => 'login'
  get  'logout' => 'login_info#logout', :as => 'logout'
  # post 'create' => 'login_info#create', :as => 'create'


  get 'specific_designer_list' => 'specific_designer#list', :as => 'specific_designer_list'
  get 'specific_designer/edit' => 'specific_designer#edit', :as => 'specific_designer/edit'
  post 'specific_designer/update' => 'specific_designer#update', :as => 'specific_designer/update'
  delete 'specific_designer/destroy' => 'specific_designer#destroy', :as => 'specific_designer/destroy'

  get 'specific_model_list' => 'specific_model#list', :as => 'specific_model_list'
  get 'specific_model/edit' => 'specific_model#edit', :as => 'specific_model/edit'
  post 'specific_model/update' => 'specific_model#update', :as => 'specific_model/update'
  delete 'specific_model/destroy' => 'specific_model#destroy', :as => 'specific_model/destroy'

  get 'specific_photographer_list' => 'specific_photographer#list', :as => 'specific_photographer_list'
  get 'specific_photographer/edit' => 'specific_photographer#edit', :as => 'specific_photographer/edit'
  post 'specific_photographer/update' => 'specific_photographer#update', :as => 'specific_photographer/update'
  delete 'specific_photographer/destroy' => 'specific_photographer#destroy', :as => 'specific_photographer/destroy'

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

  get 'application/index' => 'application#index', :as => 'application/index'

  get 'search_engine/show' => 'search_engine#show', :as => 'search_engine/show'
  get 'search_engine/search' => 'search_engine#search', :as => 'search_engine/search'

  get 'job_search/jobshow' => 'job_search#jobshow', :as => 'job_search/jobshow'
  #get 'job_search/jobsearch' => 'job_search#jobsearch', :as => 'job_search/jobsearch'

  # get 'job_info/post_job' => 'job_info#post_job', :as => 'job_info/post_job1'
  post '/job_info/post_job', to: 'job_info#post_job', as: 'job_info_post_job'
  get 'job_info/index',   to: 'job_info#index',  as: 'job_info/index'
  get 'job_info/search', to: 'job_info#search', as: 'job_info/search'
  get 'job_info/new_job', to: 'job_info#new_job', as: 'job_info_new_job'
  get 'job_info/show/:id', to: 'job_info#show', as: 'job_info_show'
  # delete 'job_info/:id/del(.:format)', to: 'job_info#destroy', as: 'del_job_info'
  get '/job_info/:id/del', to: 'job_info#destroy', as: 'del_job_info'
  get '/job_info/:id/visitor', to: 'job_info#visitor_show', as: 'visitor_job_info'

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'

  # Defines the root path route ("/")
  # root "articles#index"
  get 'chat', to: 'chat#index'
  post 'chat', to: 'chat#chat'

  resources :general_info
  resources :login_info
  resources :specific_designer
  resources :specific_model
  resources :specific_photographer
  resources :search_profile
  resources :template

  # for job function
  resources :job_info

#halting this changes, later will check

resources :galleries do
  resources :images, only: [:create, :destroy]
end

  resources :galleries, except: :destroy do
    resources :reviews

    # NXTFolio : Added in Spring 2023 for tagging feature
    resources :gallery_taggings, only: [:create, :destroy]

  end

  resources :search_engine
  resources :job_search


  devise_scope :user do
    get 'sign_up', to: 'login_info#new', as: :new_user_registration
    post 'sign_up', to: 'login_info#create', as: :user_registration
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    post 'sign_in', to: 'devise/sessions#create', as: :user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  root 'application#index'

 

end

#end

#>>>>>>> refs/remotes/origin/baichuan_update_gallery
