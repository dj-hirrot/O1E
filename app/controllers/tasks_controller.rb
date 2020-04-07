class TasksController < ApplicationController
  before_action :set_category, only: [:index, :edit, :update, :destroy]
  before_action :set_subject
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    if request.xhr?
      @tasks = @subject.tasks.where(user_id: current_user.id).order(created_at: :desc)
      render partial: 'tasks'
    else
      raise ActionController::RoutingError.new(params[:path])
    end
  end

  def create
    @task = @subject.tasks.build(user_id: current_user.id)

    if @task.update(task_params)
      @subject.update_progress(current_user.id)
      render json: { task: @task }, status: 200
    else
      render json: { task: @task.errors.full_messages }, status: 422
    end
  end

  def edit
    render partial: 'edit_modal'
  end

  def update
    if @task.update(task_params)
      @subject.update_progress(current_user.id)
      render json: { task: @task }, status: 200
    else
      render json: { task: @task.errors.full_messages }, status: 422
    end
  end

  def destroy
    @task.destroy
    @subject.update_progress(current_user.id)
    flash[:success] = 'タスクを削除しました'
    redirect_to category_subject_url(@category.code, @subject)
  end

  private
    def set_category
      @category = Category.find_by(code: params[:category_code])
    end

    def set_subject
      @subject = Subject.find(params[:subject_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :done)
    end
end
