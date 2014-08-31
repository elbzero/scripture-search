class CreateMediaBookmarks < ActiveRecord::Migration
  def change
    create_table :media_bookmarks do |t|
      t.decimal :startTime
      t.integer :media_file_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
