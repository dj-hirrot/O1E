class SubjectsController < ApplicationController
  before_action :set_category

  def index
    @subjects = @category.subjects.where(user_id: current_user.id).order(created_at: :desc)
    render partial: 'subjects'
  end

  def create
    @subject = @category.subjects.build(user_id: current_user.id)

    if @subject.update(subject_params)
      render json: { subject: @subject }, status: 200
    else
      render json: { subject: @subject.errors.full_messages }, status: 422
    end
  end

  private
    def set_category
      @category = Category.find_by!(code: params[:category_code])
    end

    def subject_params
      params.require(:subject).permit(:name, :description)
    end
end
