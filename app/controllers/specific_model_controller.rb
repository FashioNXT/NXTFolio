 class SpecificModelController < ApplicationController
   def list
     @specific_models = SpecificModel.all
   end

   def show
     @specific_model = SpecificModel.find(params[:id])
   end

   # Associated with the view used for search_redirect
   def search
   end

   # Displays the correct specific profile search when selected during SpecificModel search
   def search_redirect
     @params_arg = params
     @checkboxes = params[:checkboxes]

     @user_objects = SpecificModel.search flash[:general_queries], @checkboxes, @params_arg
     @attribute_param_array = Array.new

     @user_objects.each do |specific_model_obj|
       @general_info_object = GeneralInfo.find_by(userKey: specific_model_obj[:user_key])

       @attribute_param = specific_model_obj.attribute_values
       @attribute_param[:user_key] = specific_model_obj[:user_key]
       @attribute_param[:first_name] = @general_info_object[:first_name]
       @attribute_param[:last_name] = @general_info_object[:last_name]
       @attribute_param[:gender] = @general_info_object[:gender]
       @attribute_param[:state] = @general_info_object[:state]
       @attribute_param[:profession] = @general_info_object[:profession]

       @attribute_param_array.push(@attribute_param)
     end

     redirect_to search_model_show_path
   end

   # Associated with the view used for create
   def new
     @specific_model = SpecificModel.new
   end

   # Create is called upon for the 3rd part of profile creation
   def create
     @specific_model = SpecificModel.new(specific_model_param)
     @genre_str = ""
     if !params[:specific_model][:allgenres].nil?
       for index in 0 ... params[:specific_model][:allgenres].size
          @genre_str = @genre_str.to_s + params[:specific_model][:allgenres][index] + ","
       end
     else
     end

     # Sets genre for the SpecificModel object
     @specific_model.genre = @genre_str
     # Assigns user_key to be the session key of the current room
     @specific_model.user_key = session[:current_user_key]

     # If SpecificModel object saved correctly to database, displays home page
     # Else displays the SpecificModel new view
     if @specific_model.save!
       redirect_to '/show_profile'
     end
   end

   # Allows room to edit the params of the SpecificModel object
   # Displays information pulled from database that matches the session key of the current room
   # Associated with the view used for update
   def edit
     if SpecificModel.exists?(:user_key => session[:current_user_key])
       @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])
     else
       redirect_to :action => 'new'
     end
   end

   # Saves the edit of the SpecificModel object to the database
   def update
     @specific_model = SpecificModel.find_by(user_key: session[:current_user_key])

     # if @specific_model.update_attributes(specific_model_param)
     if @specific_model.update(specific_model_param)
       redirect_to '/show_profile'
     end
   end
   # Params used to create and edit the SpecificModel object
   def specific_model_param
     params.require(:specific_model).permit(:height_feet, :height_inches, :bust, :waist, :hips, :cups, :shoe_size, :dress_size, :hair_color, :eye_color, :ethnicity, :skin_color, :shoot_nudes, :tattoos, :piercings, :experience, :genre, {:allgenres => []})
   end

   # Not implemented
   def destroy
     SpecificModel.find_by_user_key(params[:user_key]).destroy
     redirect_to root_path
   end
 end
