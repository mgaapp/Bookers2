class BooksController < ApplicationController
    def new
    @book = Book.new
  end

def show
    @book = Book.find(params[:id])  # 正しく取得できているか
    @user = @book.user
    @books = @book.user.books

  end

# 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = Current.user.id
    if @book.save
    redirect_to books_path
    else
    render :new, status: :unprocessable_entity
    end
  end
  
  def index 
    @books = Book.all
    @book = Book.new 
  end

def destroy
    book = Book.find(params[:id])
    if book.user == current_user
    book.destroy
    redirect_to books_path
    else
    redirect_to books_path, alert: '削除する権限がありません'
  end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: 'Bookを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end


   # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end