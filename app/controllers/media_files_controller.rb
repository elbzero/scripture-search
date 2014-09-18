class MediaFilesController < ApplicationController
  before_action :set_media_file, only: [:show, :edit, :update, :destroy, :bookmark]

  # GET /media_files
  # GET /media_files.json
  def index
    # if params[:search] and params[:tag]
    #   @media_files = MediaBookmark.where( "lower(topic) like ? or lower(description) like ? or lower(title) like ?", 
    #                                   "%#{params[:search].downcase}%", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").page(params[:page])
    
    # elsif params[:search]
    #   @media_bookmarks = MediaBookmark.where( "lower(topic) like ? or lower(description) like ? or lower(title) like ?", 
    #                                   "%#{params[:search].downcase}%", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").page(params[:page])
    # elsif params[:tag]
    #   @current_tag = params[:tag]
    #   @media_bookmarks = MediaBookmark.tagged_with(params[:tag]).page(params[:page])
    # else
    #   @media_bookmarks = MediaBookmark.all.page(params[:page])
    # end
    #   @media_bookmarks_topic = @media_bookmarks.group_by { |t| t.topic }

    @media_files = MediaFile.all.page(params[:page])
  end

  def find_tags
    @tags = Tag.where( "name like ?","#{params[:term]}%")

    @tag_names = Array.new

    @tags.each do|tag|
      @tag_names.push(tag.name)
    end

    render json: @tag_names
  end

  def bookmark
    @bookmark = MediaBookmark.find(params[:bookmark])
    if params[:start_at_bookmark]
      @start_at_bookmark = MediaBookmark.find(params[:start_at_bookmark])
    end
    @media_bookmarks = MediaBookmark.where( "media_file_id = ?", @media_file.id )

    render :show
  end

  # GET /media_files/1
  # GET /media_files/1.json
  def show
    if params[:start_at_bookmark]
      @bookmark = MediaBookmark.find(params[:start_at_bookmark])
    else
      @bookmark = @media_file.start_bookmark
    end
    @media_bookmarks = media_bookmarks
  end

  def media_bookmarks
    @media_bookmarks = MediaBookmark.where( "media_file_id = ?", @media_file.id )
  end

  # GET /media_files/new
  def new
    @media_file = MediaFile.new
  end

  # GET /media_files/1/edit
  def edit
  end

  def create_start_bookmark
    @media_bookmark = MediaBookmark.new(media_bookmark_params)
    @media_bookmark.startTime = 0
    @media_bookmark.media_file_id = @media_file.id
    @media_bookmark.save
    @media_bookmark
  end

  # POST /media_files
  # POST /media_files.json
  def create
    if !params[:media_file].nil?
      @media_file = MediaFile.new(media_file_params)
    else
      @media_file = MediaFile.new
    end
    @media_file.save
    @media_file.start_bookmark = create_start_bookmark

    respond_to do |format|
      if @media_file.save
        format.html { redirect_to @media_file, notice: 'Media file was successfully created.' }
        format.json { render :show, status: :created, location: @media_file }
      else
        format.html { render :new }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_files/1
  # PATCH/PUT /media_files/1.json
  def update
    respond_to do |format|
      if @media_file.update(media_file_params) and @media_file.start_bookmark.update(media_bookmark_params)
        format.html { redirect_to @media_file, notice: 'Audio file was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_file }
      else
        format.html { render :edit }
        format.json { render json: @media_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_files/1
  # DELETE /media_files/1.json
  def destroy

    media_bookmarks.each do |bookmark|
      bookmark.destroy
    end

    @media_file.destroy
    respond_to do |format|
      format.html { redirect_to media_files_url, notice: 'Audio file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_file
      @media_file = MediaFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def media_file_params
      params[:media_file].permit(:media_attachment)
    end

    def media_bookmark_params
      params[:media_bookmark].permit(:title, :description, :tag_list, :topic_list, :topic)
    end
end
