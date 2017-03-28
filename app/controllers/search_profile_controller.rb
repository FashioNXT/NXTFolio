class SearchProfileController < ApplicationController
  #Variable that holds a params/object with all the attributes filled in
  def list
    @search_profile = SearchProfile.all
  end
   
  def show
    @search_profile = SearchProfile.find(params[:id])
  end
   
  def create
  end
  
  def search_profile_params
    #passing into create with these keys.
    params.require(:search_profile).permit(:email, :password, :password_confirmation)
  end
  
  def search
  end
   
  def edit
    @search_profile = SearchProfile.find(params[:id])
  end
   
  def update
    @search_profile = SearchProfile.find(params[:id])
    	
    if @search_profile.update_attributes(login_info_param)
      redirect_to :action => 'show', :id => @login_info
    else
      render :action => 'edit'
    end
  end

  def search_profile_param
     params.require(:login_info).permit(:title, :price, :subject_id, :description)
  end
   
  def delete
    SearchProfile.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  # def login
    
  # end
    
end
