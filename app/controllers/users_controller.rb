class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :edit_account, :edit_profile, :update_profile, :update_account]

  def show
  end

  def edit
  end
  
  def edit_account
  end

  def edit_profile
  end

  # プロフィール更新用
  def update_profile
    if @user.update(params.require(:user).permit(:name, :bio, :avatar, :remove_avatar))
      flash[:notice] = "プロフィールを更新しました"
      redirect_to user_path(current_user)
    else
      render "edit_profile", status: :unprocessable_entity
    end
  end

  # アカウント情報更新用
  def update_account
    if @user.update(params.require(:user).permit(:email, :password, :password_confirmation))
      flash[:notice] = "アカウント情報を更新しました"
      redirect_to user_path(current_user)
    else
      render "edit_account", status: :unprocessable_entity
    end
  end

  def destroy
  end
end

private

def set_user
  @user = User.find(params[:id])
end