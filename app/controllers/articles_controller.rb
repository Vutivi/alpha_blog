class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
  end

  def edit
  end 

  def destroy
    if @article.destroy
      flash[:success] = "Article was succesfully destroyed!"
      redirect_to articles_path
    else
      flash[:danger] = "Article cannot be destroyed!"
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article was succesfully created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was succesfully updated!"
      redirect_to article_path(@article)
    else
      flash[:danger] = "Could not update article!"
      render :edit
    end
  end

  private

    def set_article
      @article =Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit or delete your own article!"
        redirect_to root_path
      end
    end
end
