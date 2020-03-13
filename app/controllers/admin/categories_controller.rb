class Admin::CategoriesController < Admin::ApplicationController
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
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
