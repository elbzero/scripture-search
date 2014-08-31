class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.integer :start_bookmark

      t.timestamps
    end
  end
end
