class BooksController < ApplicationController
  before_action :authorized
  # before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    # @books = Book.all
    @books = Book.where(user_id: @user.id)

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user_id = @user.id

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  def is_tbr
    @book = Book.where({isTBR: true})
    render json: @book
  end

  def is_reading
    @book = Book.where({isReading: true})
    render json: @book
  end

  def is_read
    @book = Book.where({isRead: true})
    render json: @book
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :author, :rating, :isTBR, :isReading, :isRead, :user_id)
    end
end
