class Admin::TasksController < Admin::ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "#{@task.name}を更新しました。"
      redirect_to admin_tasks_url
    else
      flash.now[:danger] = 'タスクの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to admin_tasks_url, success: 'タスクを削除しました。'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :done)
    end
end
