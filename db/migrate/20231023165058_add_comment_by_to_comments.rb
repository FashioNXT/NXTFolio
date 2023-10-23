class AddCommentByToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :comment_by, :string
  end
end
