require 'rails_helper'

RSpec.describe UserActivityDetail, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  describe "scopes" do
    before do
      @activity1 = UserActivityDetail.create(created_at: 2.days.ago)
      @activity2 = UserActivityDetail.create(created_at: 1.day.ago)
    end

    it "orders activities by most recent first" do
      expect(UserActivityDetail.recent).to eq([@activity2, @activity1])
    end
  end
end
