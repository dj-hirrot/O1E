class Admin::SubjectsController < Admin::ApplicationController
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      flash[:success] = "#{@subject.name}を更新しました。"
      redirect_to admin_subjects_url
    else
      flash.now[:danger] = '科目の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @subject.destroy
    redirect_to admin_subjects_url, success: 'タスクを削除しました。'
  end

  private
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def subject_params
      params.require(:subject).permit(:name, :description)
    end
end
