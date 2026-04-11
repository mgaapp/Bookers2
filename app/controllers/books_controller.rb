class BooksController < ApplicationController
    def new
    @books = Book.new
end

# 投稿データの保存
  def create
    @books = Books.new(books_params)
    @books.user_id = Current.user.id
    if @books.save
    redirect_to books_path
    else
    render :new, status: :unprocessable_entity
    end
  end
  
  def index 
    @books = Book.all
  end

def destroy
    books = Books.find(params[:id])
    books.destroy
    redirect_to 'books'
  end

   # 投稿データのストロングパラメータ
  private

  def books_params
    params.require(:books).permit(:name, :email_address, :password, :password_confirmation)
  end
end