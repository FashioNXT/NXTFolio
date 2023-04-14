class AddInvitedEmailToGalleryTagging < ActiveRecord::Migration[6.1]
  def change
    add_column :gallery_taggings, :invited_email, :string
  end
end
