class AddTopicColumn < ActiveRecord::Migration
  def change
    add_column :media_bookmarks, :topic, :string
  end
end
