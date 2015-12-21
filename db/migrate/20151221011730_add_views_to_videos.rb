class AddViewsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :views, :integer
  end
end
