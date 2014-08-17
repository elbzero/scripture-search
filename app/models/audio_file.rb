class AudioFile < ActiveRecord::Base
  acts_as_taggable
  has_attached_file :audio_attachment
  validates_attachment_content_type :audio_attachment, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ], message: "Only audio file types are allowed"
end
