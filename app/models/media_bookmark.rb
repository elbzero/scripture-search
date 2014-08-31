class MediaBookmark < ActiveRecord::Base
  acts_as_taggable
  acts_as_taggable_on :topics
  belongs_to :media_file

  def duration
    t = self.startTime # seconds
    Time.at(t).utc.strftime("%H:%M:%S")
  end
end
