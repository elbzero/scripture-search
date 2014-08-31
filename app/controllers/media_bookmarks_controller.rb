class MediaBookmarksController < ApplicationController
  
  def add_bookmark
    if params[:media_file_id]
      @media_bookmark = MediaBookmark.new(media_bookmark_params)
      @media_bookmark.save
    end

    render json: { success: true }
  end

  def media_bookmark_params
    params.permit(:title, :description, :tag_list, :startTime, :media_file_id)
  end
end
