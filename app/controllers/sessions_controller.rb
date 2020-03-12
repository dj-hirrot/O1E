class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      login @user
      remember @user
      flash[:success] = 'ログインに成功しました'
      redirect_to root_url
    else
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
