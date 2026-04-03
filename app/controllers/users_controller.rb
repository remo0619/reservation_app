class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.avatar.attached(params[:user][:avatar]) if @user.avatar.blank?
    if @user.update(params.require(:user).permit(:name, :email, :bio, :avatar, :remove_avatar))
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to user_path(current_user)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
  end
end