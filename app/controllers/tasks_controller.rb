class TasksController < ApplicationController
  before_action :check_loggedin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.user = current_user

    if task.save
      redirect_to task_path(task), notice: "Task Created Succesfully"
    else
      redirect_to new_task_path, notice: task.errors.full_messages
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "Task Updated Succesfully"
    else
      redirect_to edit_task_path, notice: @task.errors.full_messages
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, notice: "Task Deleted Succesfully"
    else
      redirect_to tasks_path, notice: @task.errors.full_messages
    end
  end

  private

  def task_params
    params.require(:task).permit(:start_date, :end_date, :description)
  end

  def find_task
    @task ||= Task.find(params[:id])
  end
end
