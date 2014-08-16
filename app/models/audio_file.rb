class AudioFile < ActiveRecord::Base
  acts_as_taggable
  has_attached_file :audio_attachment
  do_not_validate_attachment_file_type :audio_attachment
end
