class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show]
  
  
  def index
    if logged_in?
      @tasks = current_user.tasks
    end
  end

  def show
    if logged_in?
      @task = Task.find(params[:id])
    end
  end

  def new
    if logged_in?
      @task = Task.new
    end
  end

  def create
    if logged_in?
      @task = current_user.tasks.build(task_params)

      if @task.save
        flash[:success] = 'タスクが追加されました'
        redirect_to @task
      else
        @task = current_user.tasks
        flash[:danger] = 'タスクが追加できません'
        render :new
      end
    end
  end
  
  def edit
    if logged_in?
      @task = Task.find(params[:id])
    end
  end

  def update
    if logged_in?
      if @task.update(task_params)
         flash[:success] = 'タスクが編集されました'
         redirect_to @task
      else
         flash.now[:danger] = 'タスクが編集されませんでした'
         render :edit
      end
    end
  end

  def destroy
    if logged_in?
      @task.destroy

      flash[:success] = 'タスクが削除されました'
      redirect_to tasks_url
    end
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
    
    
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end