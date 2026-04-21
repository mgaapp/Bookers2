class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  before_action :is_matching_login_user, only: [:edit, :update]
  

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "Signed in successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end


  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books.order(created_at: :desc)
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])

  end
    


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def is_matching_login_user
  user = User.find(params[:id])
  unless user == current_user
    redirect_to user_path(current_user), alert: "You are not authorized to edit this user."
  end
end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :email_address, :password, :password_confirmation)
  end
end




