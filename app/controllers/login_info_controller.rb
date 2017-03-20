class LoginInfoController < ApplicationController
  
  #Variable that holds a params/object with all the attributes filled in
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
    #@login_info = LoginInfo.new(params[:login_info])
    puts @login_info[:email]
    puts @login_info[:password]
    puts login_info_params[:password_confirmation]
    
    if @login_info[:password] == login_info_params[:password_confirmation]
      puts "true"
      #if @login_info.save
      #  puts "saved"
      #redirect_to :action => 'list'
      redirect_to new_general_info_path and return
    else
      puts "false"
      #puts "Failed Saving"
      render :action=> 'new'                  # Render the new page again
    end
  end
  
  def login_info_params
    #passing into create with these keys.
    params.require(:login_info).permit(:email, :password, :password_confirmation)
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
     params.require(:login_info).permit(:title, :price, :subject_id, :description)
  end
   
  def delete
    LoginInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
