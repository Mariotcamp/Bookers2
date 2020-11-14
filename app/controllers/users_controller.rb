class UsersController < ApplicationController
    before_action :authenticate_user!
  def show
    @user = User.find(params[:id])#最初ここをcurrent_user.idにして要は住んでいたがuserの機能を作る上でそれではuserの名前をクリックした時に同じログインしている人の本しか表示されなくなってしまう、だからしっかりparamsで取得せなあかんわけだったんだ。
    @book = Book.new
    @books = @user.books#ここをallにしてしまうとbook#indexと同じことになってしまうからダメ！→アソシエーションか
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new #これ渡さないとエラ〜メッセージのテンプレートが読めなくなる
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:success] = "User info is updated successfully"
       redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)#これないとaregumentエラーになるからもしそうなったらこれ忘れてないか確認。
  end
end
