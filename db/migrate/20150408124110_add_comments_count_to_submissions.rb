class AddCommentsCountToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :comments_count, :integer, default: 0
  end
end
