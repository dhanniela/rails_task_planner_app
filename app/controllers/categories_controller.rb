class CategoriesController < ApplicationController
    before_action :authenticate_user! # user must be logged in before accessing category actions
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    # GET /categories
    def index
        @categories = current_user.categories
    end

    # GET /categories/:id
    def show
        # The category is already set by the before_action callback
    end

    # GET /categories/new
    def new
        @category = current_user.categories.build
    end

    # POST /categories
    def create
        @category = current_user.categories.build(category_params)

        if @category.save
            redirect_to @category, notice: 'Category was successfully created.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # GET /categories/:id/edit
    def edit
        # The category is already set by the before_action callback
    end

    # PATCH/PUT /categories/:id
    def update
        # The category is already set by the before_action callback

        if @category.update(category_params)
            redirect_to @category, notice: 'Category was successfully updated.'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /categories/:id
    def destroy
        # The category is already set by the before_action callback

        @category.destroy

        redirect_to categories_path, notice: 'Category was successfully deleted.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
        @category = current_user.categories.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
        params.require(:category).permit(:name, :description)
    end
end