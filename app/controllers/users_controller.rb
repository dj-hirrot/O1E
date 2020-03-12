class UsersController < ApplicationController
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

  private
    def user_params
      params.require(:user).permit(user_param_items)
    end

    def user_param_items
      [
        :name, :email, :password, :password_confirmation
      ]
    end
end
