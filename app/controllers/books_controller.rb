class BooksController < ApplicationController
    def new
    @book = Book.new
  end

def show
    @book = Book.find(params[:id])  # 正しく取得できているか
  end

# 投稿データの保存
  def create
    @book = Books.new(books_params)
    @book.user_id = Current.user.id
    if @book.save
    redirect_to book_path
    else
    render :new, status: :unprocessable_entity
    end
  end
  
  def index 
    @books = Book.all
  end

def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

   # 投稿データのストロングパラメータ
  private

  def books_params
    params.require(:book).permit(:name, :email_address, :password, :password_confirmation)
  end
end