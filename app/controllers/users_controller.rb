class UsersController < ApplicationController
  def index
  end
  def new
  end
  def create
  end
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name, :email))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to :users
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
  end
end
