class BooksController < ApplicationController
    def new
    @books = Books.new
end
