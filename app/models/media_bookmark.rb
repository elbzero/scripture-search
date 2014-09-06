# == Schema Information
#
# Table name: media_bookmarks
#
#  id            :integer          not null, primary key
#  startTime     :decimal(, )
#  media_file_id :integer
#  title         :string(255)
#  description   :text
#  created_at    :datetime
#  updated_at    :datetime
#

class MediaBookmark < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :topics
  belongs_to :media_file

  def duration
    t = self.startTime # seconds
    Time.at(t).utc.strftime("%H:%M:%S")
  end
end
