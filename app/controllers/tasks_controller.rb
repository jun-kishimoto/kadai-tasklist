class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
 
  def index
    # @tasks = Task.order(id: :desc).page(params[:page]).per(15)
    @tasks = current_user.tasks.page(params[:page]).per(15)
    # @tasks = Task.where(user_id: current_user.id).page(params[:page]).per(15)
    # @tasks = Task.where(user: current_user).page(params[:page]).per(15)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "Task は正常に更新されました"
      # redirect_to @taskはTasksControllerのshowにとぶ
      # redirect_to @task
      redirect_back(fallback_location: root_url)
    else
      flash.now[:danger] = "Task は更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "Task は正常に削除されました"
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def check_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end