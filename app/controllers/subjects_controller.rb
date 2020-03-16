class SubjectsController < ApplicationController
  before_action :set_category

  def new
    @subject = @category.subjects.build
  end

  private
    def set_category
      @category = Category.find_by!(code: params[:category_code])
    end
end
