class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "Article was succesfully destroyed."
      redirect_to articles_path
    else
      flash[:error] = "Article cannot be destroyed."
    end

  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was succesfully created."
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was succesfully updated."
      redirect_to article_path(@article)
    else
      flash[:notice] = "Could not update article."
      render :edit
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
