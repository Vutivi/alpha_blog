class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_user, only: [:new, :create, :edit, :destroy]
  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
  end


  def show
    @category_articles = @category.articles.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category succesfully saved!"
      redirect_to categories_path
    else
      flash[:danger] = "Category could not be saved!"
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category succesfully updated!"
      redirect_to categories_path
    else
      flash[:danger] = "Category could not be updated!"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = "Category have been succesfully destroyed!"
      redirect_to categories_path
    else
      flash[:danger] = "Category could not be destroyed!"
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin_user
      if !logged_in? || (logged_in? & !current_user.admin?)
        flash[:danger] = "Not Authorized"
        redirect_to categories_path
      end
    end
end
