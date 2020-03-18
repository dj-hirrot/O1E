class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  def show
    @subject = @category.subjects.build(user_id: current_user.id)
    @subjects = @category.subjects
  end

  private
    def set_category
      @category = Category.find_by!(code: params[:code])
    end
end
