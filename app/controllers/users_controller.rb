class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:new, :create]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success]   = "Welcome to the Alpha Blog #{params[:username]}!"
      redirect_to user_path(@user)
    else
      flash[:danger] = "User could not be saved!"
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "User succesfully destroyed!"
      redirect_to users_path
    else
      flash[:danger] = "User could not be destroyed!"
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User succesfully updated!"
      redirect_to user_path(@user)
    else
      flash[:danger] = "User could not be updated!"
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "You can only edit or delete your own account!"
        redirect_to root_path
      end
    end
end
