class MediaFile < ActiveRecord::Base
  has_many :media_bookmarks
  acts_as_taggable
  acts_as_taggable_on :topics
  has_attached_file :media_attachment
  validates_attachment_content_type :media_attachment, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ], message: "Only audio file types are allowed"
end
