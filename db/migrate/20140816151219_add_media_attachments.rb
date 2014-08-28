class AddMediaAttachments < ActiveRecord::Migration
  def self.up
    add_attachment :media_files, :media_attachment
  end

  def self.down
    remove_attachment :media_files, :media_attachment
  end
end
