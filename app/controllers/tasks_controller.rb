class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  # GET /tasks/:id
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    title = params[:task][:title]
    details = params[:task][:details]
    if params[:task][:completed] == "0"
      completed = false
    else
      completed = true
    end
    # new_task = Task.new(title: title, details: details, completed: completed)
    #  refactored ... to avoid forbidenAttributeError. see private method
    new_task = Task.new(task_params)
    new_task.save

    redirect_to task_path(new_task)
  end

  #get "tasks/:id/edit", to: "tasks#edit"
  def edit
    # raise
    @task = Task.find(params[:id])
    # @task =
  end

  #patch /tasks/id:
  # PATCH /kittens/:id
  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    redirect_to tasks_path(@task)
  end

  # DELETE /tasks/:id
  def destroy
    @task = Tasks.find(params[:id])
    @task.destroy

    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
