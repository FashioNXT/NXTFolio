class Message < ApplicationRecord
  belongs_to :general_info
  belongs_to :room
  after_commit :notify, on: :create
  
  def notify
    @from = self.general_info_id
    @user = GeneralInfo.find_by(id: self.chatting_with)
    @user.notification = true
    @user[:notification_from].append(@from)
    @user.save
  end
end
