class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

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
      login @user
      flash[:success] = "確認用メールを送信しました"
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
    def set_user
      @user = User.find_by(name: params[:name])
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
