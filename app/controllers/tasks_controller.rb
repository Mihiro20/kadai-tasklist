class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show]
  
  
  def index
      @tasks = Task.all
  end

  def show
  end

  def new
      @task = Task.new
  end

  def create
      @task = Task.new(task_params)

      if @task.save
        flash[:success] = 'タスクが追加されました'
        redirect_to @task
      else
        flash[:danger] = 'タスクが追加できません'
        render :new
      end
  end

  def edit
  end

  def update
      if @task.update(task_params)
         flash[:success] = 'タスクが編集されました'
         redirect_to @task
      else
         flash.now[:danger] = 'タスクが編集されませんでした'
         render :edit
      end
  end

  def destroy
      @task.destroy

      flash[:success] = 'タスクが削除されました'
      redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
    
    
  def task_params
        params.require(:task).permit(:content, :status)
  end
end