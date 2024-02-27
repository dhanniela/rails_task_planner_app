class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    # GET /tasks
    def index
        @tasks = current_user.tasks
    end

    # GET /tasks/:id
    def show
        # The task is already set by the before_action callback
    end

    # GET /tasks/new
    def new
        @task = current_user.tasks.build
    end

    # POST /tasks
    def create
        @task = current_user.tasks.build(task_params)

        if @task.save
            redirect_to @task, notice: 'Task was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # GET /tasks/:id/edit
    def edit
        # The task is already set by the before_action callback
    end

    # PATCH/PUT /tasks/:id
    def update
        # The task is already set by the before_action callback

        if @task.update(task_params)
            redirect_to @task, notice: 'Task was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /tasks/:id
    def destroy
        # The task is already set by the before_action callback

        @task.destroy

        redirect_to tasks_path, notice: 'Task was successfully deleted.'
    end

    def today
        if params[:category_id]
          @category = Category.find(params[:category_id])
          @tasks = @category.tasks.where("due_date = ? OR scheduled_date = ?", Date.today, Date.today)
        else
          @tasks = current_user.tasks.where("due_date = ? OR scheduled_date = ?", Date.today, Date.today)
        end
        
        render :index
    end
      
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
        @task = current_user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
        params.require(:task).permit(:category_id, :title, :description, :due_date, :scheduled_date, :status)
    end

end