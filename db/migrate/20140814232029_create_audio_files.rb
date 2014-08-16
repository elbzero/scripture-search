class CreateAudioFiles < ActiveRecord::Migration
  def change
    create_table :audio_files do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
