class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  #before_action :require_admin_user
  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10)
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

  def show
  end

  def edit
  end

  def update
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin_user
      if !current_user.admin?
        flash[:danger] = "Not Authorized"
        redirect_to root_path
      end
    end
end
