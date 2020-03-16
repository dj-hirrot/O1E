class SubjectsController < ApplicationController
  before_action :set_category

  def new
    @subject = @category.subjects.build
    @subject.user_id = current_user.id
    render partial: 'form'
  end

  private
    def set_category
      @category = Category.find_by!(code: params[:category_code])
    end
end
