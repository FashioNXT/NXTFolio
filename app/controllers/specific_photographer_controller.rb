 class SpecificPhotographerController < ApplicationController
   def list
     @specific_photographers = SpecificPhotographer.all
   end

   def show
     @specific_photographer = SpecificPhotographer.find(params[:id])
   end

   def new
     @specific_photographer = SpecificPhotographer.new
   end

   def create
     @specific_photographer = SpecificPhotographer.new(specific_photographer_params)
     @genre_str
     if !params[:specific_photographer][:allgenres].nil?
       for index in 0 ... params[:specific_photographer][:allgenres].size
          @genre_str = @genre_str.to_s + params[:specific_photographer][:allgenres][index] + ","
       end
     else
     end

     #puts @genre_str
     @specific_photographer.genre = @genre_str
     @specific_photographer.user_key = session[:current_user_key]

     if @specific_photographer.save!
       puts "Saved and returning the profile"
       redirect_to '/show_profile'
     end
   end

   def specific_photographer_params
     params.require(:specific_photographer).permit(:compensation, {:allgenres => []} , :experience, :influencers, :specialties, :genre)
   end

   def edit
     if SpecificPhotographer.exists?(:user_key => session[:current_user_key])
       @specific_photographer = SpecificPhotographer.find_by(user_key: session[:current_user_key])
     else
       redirect_to :action => 'new'
     end
   end

   def update
     @specific_photographer = SpecificPhotographer.find_by(user_key: session[:current_user_key])

     # if @specific_photographer.update_attributes(specific_photographers_param)
     if @specific_photographer.update(specific_photographers_param)
       redirect_to '/show_profile'
     end
   end

   def specific_photographers_param
     params.require(:specific_photographer).permit(:compensation, :experience, :influencers, :specialties, :genre)
   end

   def destroy
     SpecificPhotographer.find_by_user_key(params[:user_key]).destroy
     redirect_to root_path
   end

   def search

   end

   def search_redirect
     @checkboxes = params[:checkboxes]
     @experience = params[:experience]
     @params_arg = params

     @user_objects = SpecificPhotographer.search @checkboxes,flash[:general_queries],@experience, @params_arg

     @user_objects.each do |object|
       @general_info_object = GeneralInfo.find_by(userKey: object[:user_key])

       @attribute_param = object.attribute_values
       @attribute_param[:first_name] = object[:user_key]
       @attribute_param[:last_name] = @general_info_object[:last_name]
       @attribute_param[:gender] = @general_info_object[:gender]
       @attribute_param[:state] = @general_info_object[:state]
       @attribute_param[:profession] = @general_info_object[:profession]

       puts @attribute_param[:first_name]
       puts @attribute_param[:last_name]
       puts @attribute_param[:gender]
       puts @attribute_param[:state]
       puts @attribute_param[:profession]

     end
     redirect_to show_search_profile_path
   end

 end
