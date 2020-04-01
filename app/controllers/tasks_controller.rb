class TasksController < ApplicationController
  before_action :set_subject

  def create
    @task = @subject.tasks.build(user_id: current_user.id)

    if @task.update(task_params)
      render json: { task: @task }, status: 200
    else
      render json: { task: @task.errors.full_messages }, status: 422
    end
  end

  private
    def set_subject
      @subject = Subject.find(params[:subject_id])
    end

    def task_params
      params.require(:task).permit(:name, :description)
    end
end
