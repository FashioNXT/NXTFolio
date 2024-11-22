class Comment < ApplicationRecord
    belongs_to :gallery

  validates :body, presence: true, length: { maximum: 1000 }

  scope :recent, -> { order(created_at: :desc) }

  def author_name
    gallery.general_info.first_name + " " + gallery.general_info.last_name
  end
end
