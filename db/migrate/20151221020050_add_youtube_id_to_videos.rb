class AddYoutubeIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :youtubeId, :string
  end
end
