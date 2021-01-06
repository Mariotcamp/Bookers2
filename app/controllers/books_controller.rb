class BooksController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(current_user.id)#ここ変えましたaagaggafga
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully."
      redirect_to book_path(@book)#prefixの時しっかりid渡せよ！
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
    @users = User.all
  end

  def show
    @book = Book.new
    @createdbook = Book.find(params[:id])
    @user = @createdbook.user#ここ定義の順番ミスるなよ→先にbookの情報を定義してからそれに紐付いたuserを取り出すわけじゃんか。
    #本を投稿する時投稿された本のuserって意味になるし、一覧からshowを押した時もその本のuserってことになるから都合が良き！
    #@users = User.find(params[:id])これやるとbookのidが入ってくる原因追求しろ
    @book_comments = BookComment.new #大文字過去文字かの判断基準がわからん、モデルの命名基礎とかどうなってるっけ
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless current_user.id == @book.user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if current_user.id == book.user_id
      book.destroy
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
