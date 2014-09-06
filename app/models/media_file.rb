# == Schema Information
#
# Table name: media_files
#
#  id                            :integer          not null, primary key
#  start_bookmark                :integer
#  created_at                    :datetime
#  updated_at                    :datetime
#  media_attachment_file_name    :string(255)
#  media_attachment_content_type :string(255)
#  media_attachment_file_size    :integer
#  media_attachment_updated_at   :datetime
#

class MediaFile < ActiveRecord::Base
  has_many :media_bookmarks
  belongs_to :start_bookmark, :class_name => "MediaBookmark", :foreign_key => "start_bookmark"
  acts_as_taggable
  acts_as_taggable_on :topics
  has_attached_file :media_attachment
  validates_attachment_content_type :media_attachment, :content_type => [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ], message: "Only audio file types are allowed"

  def title
    if !self.start_bookmark.nil?
      self.start_bookmark.title
    else
      ""
    end
  end

  def description
    if !self.start_bookmark.nil?
      self.start_bookmark.description
    else
      ""
    end
  end
end
