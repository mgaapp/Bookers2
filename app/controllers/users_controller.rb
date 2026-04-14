class UsersController < ApplicationController
   allow_unauthenticated_access only: [:new, :create]
   
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to books_path, notice: 
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

 def edit
    @user = User.find(params[:id])
  end 


def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end



 private

  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :introduction)
  end

end
