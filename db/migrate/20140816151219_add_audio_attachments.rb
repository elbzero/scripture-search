class AddAudioAttachments < ActiveRecord::Migration
  def self.up
    add_attachment :audio_files, :audio_attachment
  end

  def self.down
    remove_attachment :audio_files, :audio_attachment
  end
end
