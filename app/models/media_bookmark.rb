class MediaBookmark < ActiveRecord::Base
  belongs_to :media_file

  def duration
    t = self.startTime # seconds
    Time.at(t).utc.strftime("%H:%M:%S")
  end
end
