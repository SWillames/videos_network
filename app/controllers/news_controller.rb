class NewsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  def index
    @news = News.all
  end

  def show
  end

  def new
    @news = News.new
  end

  def edit
  end

  def create
    @news = News.new(news_params)
    @news.user_id = current_user.id
    if @news.save
     redirect_to @news, notice: 'News was successfully created.'
    else
     render :new
    end
  end

  def update
    if @news.update(news_params)
      redirect_to @news, notice: 'News was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_index_url, notice: 'News was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def news_params
      params.require(:news).permit(:title, :tldr, :slug, :introduction, :body, :date, :url_image, :tag, :tag1, :tag2, :user_id)
    end
end
