class VideosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.all
  end

  def show
  end

  def new
    @video = Video.new
  end

  def edit
  end

  def create
    @video = Video.new(video_params)
    @video.user_id = current_user.id
    if @video.save
      redirect_to @video, notice: 'Video was successfully created.' 
    else
      render :new
    end
  end

  def update
      if @video.update(video_params)
        redirect_to @video, notice: 'Video was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @video.destroy
    redirect_to videos_url, notice: 'Video was successfully destroyed.'
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:title, :url, :tag, :tag1, :tag2, :user_id)
    end
end
