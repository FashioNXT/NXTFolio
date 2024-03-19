 class SpecificDesignerController < ApplicationController
   def list
     @specific_designers = SpecificDesigner.all
   end

   def show
     @specific_designer = SpecificDesigner.find(params[:id])
   end

   # Associated with the view used for search_redirect
   def search
   end

   # Displays the correct specific profile search when selected during SpecificDesigner search
  def search_redirect
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params

    @user_objects = SpecificDesigner.search @checkboxes,flash[:general_queries], @experience, @params_arg

    @user_objects.each do |object|
      @general_info_object = GeneralInfo.find_by(object[:userKey])

      @attribute_param = object.attribute_values
      @attribute_param[:first_name] = @general_info_object[:first_name]
      @attribute_param[:last_name] = @general_info_object[:last_name]
      @attribute_param[:gender] = @general_info_object[:gender]
      @attribute_param[:state] = @general_info_object[:state]
      @attribute_param[:profession] = @general_info_object[:profession]
    end

    redirect_to search_profile_show_path
  end

   # Associated with the view used for create
   def new
     @specific_designer = SpecificDesigner.new
   end

   # Create is called upon for the 3rd part of profile creation
   def create
     # Creates a SpecificDesigner object
     @specific_designer = SpecificDesigner.new(specific_designer_params)
     @genre_str
     if !params[:specific_designer][:allgenres].nil?
       for index in 0 ... params[:specific_designer][:allgenres].size
          @genre_str = @genre_str.to_s + params[:specific_designer][:allgenres][index] + ","
       end
     else
     end

     # Sets genre for the SpecificDesigner object
     @specific_designer.genre = @genre_str
     # Assigns user_key to be the session key of the current room
     @specific_designer.user_key = session[:current_user_key]

     # If SpecificDesigner object saved correctly to database, displays home page
     # Else displays the SpecificDesigner new view
     if @specific_designer.save
      redirect_to '/show_profile'
     end
   end

   # Params used to create the SpecificDesigner object
   def specific_designer_params
     params.require(:specific_designer).permit(:genre, {:allgenres => []}, :influencers, :specialties, :compensation, :experience)  #passing into create with these keys.
   end

   # Allows room to edit the params of the SpecificDesigner object
   # Displays information pulled from database that matches the session key of the current room
   # Associated with the view used for update
   def edit
     if SpecificDesigner.exists?(:user_key => session[:current_user_key])
       @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])
     else
       redirect_to :action => 'new'
     end
   end

   # Saves the edit of the SpecificDesigner object to the database
   def update
     @specific_designer = SpecificDesigner.find_by(user_key: session[:current_user_key])

     # if @specific_designer.update_attributes(specific_designer_param)
     if @specific_designer.update(specific_designer_param)
       redirect_to '/show_profile'
     end
   end

   # Params used to edit the SpecificDesigner object
   def specific_designer_param
     params.require(:specific_designer).permit(:genre, :influencers, :specialties, :compensation, :experience)
   end

   # Not implemented
   def destroy
     SpecificDesigner.find_by_user_key(params[:user_key]).destroy
     redirect_to root_path
   end
 end
