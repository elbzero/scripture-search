class MediaFilesController < ApplicationController
  before_action :set_media_file, only: [:show, :edit, :update, :destroy]

  # GET /media_files
  # GET /media_files.json
  def index
    if params[:search]
      @media_files = MediaFile.where( "description like ? or title like ?", 
                                      "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page])
    elsif params[:tag]
      @current_tag = params[:tag]
      @media_files = MediaFile.tagged_with(params[:tag]).page(params[:page])
    else
      @media_files = MediaFile.all.page(params[:page])
    end
  end

  def find_tags
    @tags = Tag.where( "name like ?","#{params[:term]}%")

    @tag_names = Array.new

    @tags.each do|tag|
      @tag_names.push(tag.name)
    end

    render json: @tag_names
  end

  # GET /media_files/1
  # GET /media_files/1.json
  def show
    if params[:start_at_bookmark]
      @start_at_bookmark = MediaBookmark.find(params[:start_at_bookmark])
    end
    @media_bookmarks = MediaBookmark.where( "media_file_id = ?", @media_file.id )
  end

  # GET /media_files/new
  def new
    @media_file = MediaFile.new
  end

  # GET /media_files/1/edit
  def edit
  end

  # POST /media_files
  # POST /media_files.json
  def create
    @media_file = MediaFile.new(media_file_params)

    respond_to do |format|
      if @media_file.save
        @media_bookmark = MediaBookmark.new
        @media_bookmark.startTime = 0
        @media_bookmark.media_file_id = @media_file.id
        @media_bookmark.note = "Start"
        @media_bookmark.start = true
        @media_bookmark.save
        format.html { redirect_to @media_file, notice: 'Audio file was successfully created.' }
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
      if @media_file.update(media_file_params)
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
      params.require(:media_file).permit(:title, :description, :tag_list, :media_attachment)
    end
end
