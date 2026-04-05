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
    if @user.update(profile_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to user_path(current_user)
    else
      render "edit_profile", status: :unprocessable_entity
    end
  end

  # アカウント情報更新用
  def update_account
    if params[:user][:password].present?
      if @user.update_with_password(account_params)
        bypass_sign_in(@user)
        flash[:notice] = "アカウント情報(パスワード)を更新しました"
        redirect_to user_path(current_user)
      else
        render "edit_account", status: :unprocessable_entity
      end
    else
      if @user.update_without_password(account_params.except(:current_password))
        flash[:notice] = "アカウント情報を更新しました"
        redirect_to user_path(current_user)
      else
        render "edit_account", status: :unprocessable_entity
      end
    end
  end

  def destroy
  end
end

private

def set_user
  @user = User.find(params[:id])
end

def profile_params
  params.require(:user).permit(:name, :bio, :avatar, :remove_avatar)
end

def account_params
  params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
end