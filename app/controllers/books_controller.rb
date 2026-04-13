class BooksController < ApplicationController
    def new
    @book = Book.new
  end

def show
    @book = Book.find(params[:id])  # 正しく取得できているか
  end

# 投稿データの保存
  def create
    @book = Book.new(books_params)
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
    book.destroy
    redirect_to books_path
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

  def books_params
    params.require(:book).permit(:title, :body)
  end
end