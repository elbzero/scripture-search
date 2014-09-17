class MediaBookmarksController < ApplicationController
  before_action :set_media_bookmark, only: [:edit, :update]
  
  def add_bookmark
    @media_bookmark = MediaBookmark.new(media_bookmark_params)
    @media_bookmark.save
    render json: { success: true }
  end

  def media_bookmark_params
    params[:media_bookmark].permit(:title, :description, :tag_list, :startTime, :media_file_id, :topic)
  end

  def edit

  end

  def update
    respond_to do |format|
      if @media_bookmark.update(media_bookmark_params)
        puts "Here!!!!!!!!1"
        format.html { redirect_to media_files_path, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_bookmark }
      else
        puts "Here!!!!!!!!2"
        format.html { redirect_to media_files_path }
        format.json { render json: @media_bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_bookmark
      @media_bookmark = MediaBookmark.find(params[:id])
    end
end
