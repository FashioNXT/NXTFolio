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
    
    #DO LATER: Check user name against the database.
    if @login_info[:password] == login_info_params[:password_confirmation]
      puts "true"
      @login_info.userKey = SecureRandom.hex(10)
      puts @login_info.userKey
      session[:current_user_key] = @login_info.userKey 
      
      if @login_info.save
        puts "saved"
        flash[:notice] = "Account Created!"
        redirect_to new_general_info_path and return
      else
        puts "false"
        puts "Failed Saving"
        # flash[:alert] = "Invalid Email or Password! Please try again."
        # format.html { redirect_to @post, alert: "Invalid Email or Password! Please try again." }
        # redirect_to new_login_info_path and return               # Render the new page again
        render :action => 'new', notice: "Invalid Email or Password! Please try again."
      end
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
   
  def delete
    LoginInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def login
    @login_info = LoginInfo.new
  end
  
  def login_submit
    @login_info = LoginInfo.new(login_info_param)
    if LoginInfo.exists?(:email => @login_info[:email])
      puts "correct email"
      @login_user = LoginInfo.find_by(email: @login_info[:email])
      if @login_user[:password] == @login_info[:password]
        #login
        session[:current_user_key] = @login_user[:userKey] 
        redirect_to root_path
      else
        #wrong password - NEED TO MAKE FLASH
        flash[:notice] = "Incorrect Password"
        redirect_to login_info_login_path
      end
    else
      #User does not exist - NEED TO MAKE FLASH
      flash[:notice] = "Incorrect Email"
      redirect_to login_info_login_path
    end
  end
  
  def login_info_param
     params.require(:login_info).permit(:email, :password)
  end
  
  def logout
    session[:current_user_key] = nil
    redirect_to root_path
  end
end