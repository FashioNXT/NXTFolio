class ReviewsController < ApplicationController
  #before_action :find_general_info
  before_action :find_gallery
  before_action :find_user
  before_action :find_review, only: [:edit,:update, :destroy]



  def new
    @review=Review.new
  end

  def create
    @review=Review.new(review_params)
    @review.gallery_id=@gallery.id
    @review.user_id=@user.id
    @review.general_info_id=@general_info.id



    if @review.save
      redirect_to show_profile_show_profile_path(:user_key => @general_info.userKey)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @review=Review.find(params[:id])
    if @review.update(review_params)
      redirect_to show_profile_show_profile_path(:user_key => @general_info.userKey)
    else
      render 'edit'
    end
  end



  private

  def review_params
    params.require(:review).permit(:rating,:general_info_id,:gallery_id,:user_id)
  end

  #def find_general_info
  #@genral_info=GeneralInfo.find_by(general_info_id: params[:general_info_id])
  #end

  def find_gallery
    @gallery=Gallery.find(params[:gallery_id])
    general_info_id=@gallery.GeneralInfo_id
    @general_info=GeneralInfo.find(general_info_id)


  end

  def find_user
    @user=GeneralInfo.find_by(userKey: session[:current_user_key])
    logger.info("Controller Testing")
    logger.debug(@user.inspect)

  end

  def find_review
    @review=Review.find(params[:id])
  end

end
