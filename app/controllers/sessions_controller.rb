class SessionsController < ApplicationController
  before_action :authenticate_user?, only: [:destroy]

  def new
    if signed_in?
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        login @user
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        flash[:success] = 'ログインに成功しました'
        redirect_back_or edit_user_url(@user.name)
      else
        flash[:warning] = 'ログインに失敗しました'
        redirect_to root_url
      end
    else
      @user = User.new # ログイン失敗したら初期化
      flash.now[:danger] =  'メールアドレスかパスワードが間違っています'
      render :new
    end
  end

  def destroy
    logout if signed_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
