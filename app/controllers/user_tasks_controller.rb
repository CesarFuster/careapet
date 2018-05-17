class UserTasksController < ApplicationController

  before_action :set_user_task, only: [:show, :edit, :update, :destroy]

  def index
    @user_tasks = UserTask.all
  end

  def show
    @user_task = @user.user_task
  end

  def new
    @user_task = UserTask.new
  end

  def create
    @user_task = UserTask.new(user_task_params)
    @user_task.user = current_user
    if @user_task.save
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
    if @user_task.user != current_user
      redirect_to root_path
    end
  end

  def update
    if @user_task.user != current_user
      flash[:alert] = "Não autorizado!"
      redirect_to root_path
    else
      @user_task.update(user_task_params)
      if @user_task.save
        redirect_to current_user
      else
        render :new
      end
    end
  end

  def destroy
    if @user_task.user != current_user
      flash[:alert] = "Não autorizado!"
      render :show
    else
      @user_task.destroy
      redirect_to current_user
    end
  end

  private

  def set_user_task
    @user_task = UserTask.find(params[:id])
  end

  def user_task_params
    params.require(:user_task).permit(:price, :task_id, :user_id)
  end

end
