class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id #この6,7行目のおかげでアソシエーションが使えるようになるのかな？？
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy  #なぜかparams[:id]の方にbookのidが、book_idの方にcommentのidが入ってる
    redirect_to book_path(params[:book_id])                                  #このコメントの取得commentのidだけじゃだめの？→できた。
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
