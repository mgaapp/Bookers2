class BooksController < ApplicationController
  before_action :require_authentication
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def new
    @book = Book.new
  end

  def show
    @user = @book.user
    @books = @book.user.books
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to books_path, notice: "You have created book successfully."


    else
      @books = Book.all
      render :index, status: :unprocessable_entity
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def destroy
    if @book.user == current_user
      @book.destroy
      redirect_to books_path
    else
      redirect_to books_path, alert: "削除する権限がありません"
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

