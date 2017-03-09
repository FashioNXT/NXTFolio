class LoginInfoController < ApplicationController
  def list
    @login_infos = LoginInfo.all
  end
   
  def show
    @login_info = LoginInfo.find(params[:id])
  end
   
  def new
    @login_info = LoginInfo.new
  end
   
  def create
    @login_info = LoginInfo.new(login_info_params)
      
    if @login_info.save
      redirect_to :action => 'list'
    else
      render :action=> 'new'                  # Render the new page again
    end
  end
  
  def login_info_params
    params.require(:login_infos).permit(:email, :password)  #passing into create with these keys.
  end
   
  def edit
    @login_info = LoginInfo.find(params[:id])
  end
   
  def update
    @login_info = LoginInfo.find(params[:id])
    	
    if @login_info.update_attributes(login_info_param)
      redirect_to :action => 'show', :id => @login_info
    else
      render :action => 'edit'
    end
  end

  def login_info_param
     params.require(:login_infos).permit(:title, :price, :subject_id, :description)
  end
   
  def delete
    LoginInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
