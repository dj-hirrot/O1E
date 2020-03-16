class Admin::CategoriesController < Admin::ApplicationController
  before_action :superadmin_user?, except: [:index]
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:success] = "カテゴリ「#{@category.name}」を作成しました"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "カテゴリ「#{@category.name}」を更新しました"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = 'カテゴリを削除しました'
    redirect_to admin_categories_url
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:code, :name, :description)
    end

    def superadmin_user?
      if !superadmin?
        raise ActionController::RoutingError.new(params[:path])
      end
    end
end
