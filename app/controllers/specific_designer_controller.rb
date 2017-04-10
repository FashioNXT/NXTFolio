class SpecificDesignerController < ApplicationController
  def list
    @specific_designers = SpecificDesigner.all
  end
   
  def show
    @specific_designer = SpecificDesigner.find(params[:id])
  end
  
  def search
    
  end
  
  def search_redirect
    @checkboxes = params[:checkboxes]
    @experience = params[:checkboxes]
    @params_arg = params
    SpecificDesigner.search @checkboxes,flash[:general_queries], @experience, @params_arg
    redirect_to root_path
  end
   
  def new
    @specific_designer = SpecificDesigner.new
  end
   
  def create
    @specific_designer = SpecificDesigner.new(specific_designer_params)
    @genre_str
    if !params[:specific_designer][:allgenres].nil?
      for index in 0 ... params[:specific_designer][:allgenres].size
         @genre_str = @genre_str.to_s + params[:specific_designer][:allgenres][index] + ","
      end
    else
    end
      
    puts session[:current_user_key]
    @specific_designer.genre = @genre_str
    @specific_designer.user_key = session[:current_user_key]

    
     if @specific_designer.save!
       puts "Saved and returning to root"
       redirect_to root_path
     else
       puts "Error, returning to new"
       render :action=> 'new'                  # Render the new page again
     end
  end
  
  def specific_designer_params
    params.require(:specific_designer).permit(:genre, {:allgenres => []}, :influencers, :specialties, :compensation, :experience)  #passing into create with these keys.
  end
   
  def edit
    @specific_designer = SpecificDesigner.find(params[:id])
  end
   
  def update
    @specific_designer = SpecificDesigner.find(params[:id])
  
    if @specific_designer.update_attributes(specific_designer_param)
      redirect_to :action => 'show', :id => @specific_designer
    else
      render :action=> 'edit'                  # Render the new page again
    end
  end
  
  def specific_designer_param
    params.require(:specific_designer).permit(:genre, :influencers, :specialties, :compensation, :experience)  
  end
   
  def delete
    SpecificDesigner.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
