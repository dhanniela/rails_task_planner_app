class TasksController < ApplicationController
    before_action :set_category, only: [:new, :create, :today]
    before_action :set_task_with_category, only: [:show, :edit, :update, :destroy]

    # GET /tasks
    def index
        @tasks = current_user.tasks.includes(:category)
    end

    # GET /tasks/:id
    def show
        # The task is already set by the before_action callback
            # set_task_with_category
    end

    # GET /tasks/new
    def new
        # The task is already set by the before_action callback
            # set_category
        @task = @category.tasks.build
    end

    # POST /tasks
    def create
        # The task is already set by the before_action callback
            # set_category
        @task = @category.tasks.build(task_params.merge(user: current_user))

        if @task.save
            redirect_to @category, notice: 'Task was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # GET /tasks/:id/edit
    def edit
        # The task is already set by the before_action callback
            # set_task_with_category
    end

    # PATCH/PUT /tasks/:id
    def update
        # The task is already set by the before_action callback
            # set_task_with_category

        if @task.update(task_params)
            redirect_to @category, notice: 'Task was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /tasks/:id
    def destroy
        # The task is already set by the before_action callback
            # set_task_with_category

        @task.destroy

        redirect_to @category, notice: 'Task was successfully deleted.'
    end

    def today
        # The task is already set by the before_action callback
            # set_category
        if @category
            @tasks = @category.tasks.where("due_date = ? OR scheduled_date = ?", Date.today, Date.today)
        else
            @tasks = current_user.tasks.where("due_date = ? OR scheduled_date = ?", Date.today, Date.today)
        end
        
        render :index
    end
      
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
        @category = current_user.categories.find(params[:category_id]) if params[:category_id]
    end
    
    def set_task_with_category
        @task = current_user.tasks.find(params[:id])
        @category = @task.category
    end
    
    # Only allow a list of trusted parameters through.
    def task_params
        params.require(:task).permit(:category_id, :title, :description, :due_date, :scheduled_date, :status)
    end

end