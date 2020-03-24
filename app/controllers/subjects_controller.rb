class SubjectsController < ApplicationController
  before_action :set_category
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    if request.xhr?
      @subjects = @category.subjects.where(user_id: current_user.id).order(created_at: :desc)
      render partial: 'subjects'
    else
      raise ActionController::RoutingError.new(params[:path])
    end
  end

  def create
    @subject = @category.subjects.build(user_id: current_user.id)

    if @subject.update(subject_params)
      render json: { subject: @subject }, status: 200
    else
      render json: { subject: @subject.errors.full_messages }, status: 422
    end
  end

  def edit
    render partial: 'edit_modal'
  end

  def update
    if @subject.update(subject_params)
      render json: { subject: @subject }, status: 200
    else
      render json: { subject: @subject, errors: @subject.errors.full_messages }, status: 422
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = '科目を削除しました'
    redirect_to category_url(@category.code)
  end

  private
    def set_category
      @category = Category.find_by!(code: params[:category_code])
    end

    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :description)
    end
end
