class MediaBookmarksController < ApplicationController
  before_action :set_media_bookmark, only: [:edit]
  
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

  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_bookmark
      @media_bookmark = MediaBookmark.find(params[:id])
    end
end
