class GeneralInfoController < ApplicationController
  def list
      @general_infos = GeneralInfo.all
  end
   
  def show
     @general_info = GeneralInfo.find(params[:id])
  end
   
  def new
    @general_info = GeneralInfo.new
  end
  
  def select_next
    if params[:select_profile_id] == 1
      render :action => 'new_designer'
    elsif params[:select_profile_id] == 2
      render :action => 'new_model'
    elsif params[:select_profile_id] == 3
      render :action => 'new_photographer'
    end
  end
   
  def create
     @general_info = GeneralInfo.new(general_info_params)
     
     if @general_info.save
        redirect_to :action => 'list'
     else
        render :action => 'new'
     end
  end
  
  def general_info_params
     params.require(:general_infos).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio)
  end
   
  def edit
     @general_info = GeneralInfo.find(params[:id])
  end
   
  def update
    @general_info = GeneralInfo.find(params[:id])
     
    if @general_info.update_attributes(general_info_param)
      redirect_to :action => 'show', :id => @general_info
    else
      render :action => 'edit'
    end
  end
  
  def general_info_param
     params.require(:general_info).permit(:first_name, :last_name, :month_ofbirth, :day_ofbirth, :year_ofbirth, :gender, :country, :state, :city, :compensation, :facebook_link, :linkedIn_link, :instagram_link, :personalWebsite_link, :bio)
  end
   
  def delete
    GeneralInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end