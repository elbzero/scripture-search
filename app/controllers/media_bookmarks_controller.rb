class MediaBookmarksController < ApplicationController
  
  def add_bookmark
    if params[:media_file]
      @media_bookmark = MediaBookmark.new
      @media_bookmark.startTime = params[:startTime]
      @media_bookmark.media_file_id = params[:media_file]
      @media_bookmark.note = params[:note]
      @media_bookmark.save
    end

    render json: { success: true }
  end
end
