class UsersController < ApplicationController
  before_action :authenticate_user?, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    if signed_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email
      flash[:info] = "確認用メールを送信しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to user_url(@user.name)
    else
      flash.now[:danger] = "プロフィールの更新に失敗しました"
      render :edit
    end
  end

  private

    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def set_user
      @user = User.find_by!(name: params[:name])
    end

    def user_params
      params.require(:user).permit(user_param_items)
    end

    def user_param_items
      [
        :name, :email, :password, :password_confirmation
      ]
    end
end
