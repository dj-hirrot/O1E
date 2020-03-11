class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
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
