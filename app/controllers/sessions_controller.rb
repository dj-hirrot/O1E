class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user && @user.authenticate(params[:session][:password])
      flash.now[:success] =  "success"
      render :new
    else
      flash.now[:danger] =  "メールアドレスかパスワードが間違っています"
      render :new
    end
  end
end
