class Message < ApplicationRecord
  belongs_to :general_info
  belongs_to :room
  has_many_attached :files
  after_commit :notify, on: :create
  
  def notify
    @from = self.general_info_id
    @user = GeneralInfo.find_by(id: self.chatting_with)
    # @user.notification = true
    # @user[:notification_from].append(@from)
    # @user.save
    if @user
      @user.notification = true
      @user[:notification_from] ||= []
      @user[:notification_from].append(@from)
      @user.save
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :general_info_id, :chatting_with, :room_id)
  end
end
