class PasswordResetsController < ApplicationController
  skip_before_action :authenticate_user?
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'パスワード再設定用のメールを送信しました'
      redirect_to root_url
    else
      flash.now[:danger] = '指定されたメールアドレスで登録されているユーザーが見つかりませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      login @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードを再設定しました"
      redirect_to user_path @user.name
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
          redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "URLが有効期間切れです"
        redirect_to new_password_reset_url
      end
    end
end
