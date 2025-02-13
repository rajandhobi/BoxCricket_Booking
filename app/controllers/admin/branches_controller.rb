module Admin
  class BranchesController < ApplicationController
    before_action :authenticate_user! # Ensure admin authentication
    before_action :set_branch, only: %i[show edit update destroy]
    before_action :authorize_admin # Ensure only admins can access

    def index
      @q = Branch.ransack(params[:q])
      @branches = @q.result(distinct: true)
    end

    def show
      @grounds = @branch.grounds
    end

    def new
      @branch = Branch.new
    end

    def create
      @branch = Branch.new(branch_params)

      if @branch.save
        redirect_to admin_branches_path, notice: "Branch successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @branch.update(branch_params)
        redirect_to admin_branches_path, notice: "Branch successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @branch.destroy!
      redirect_to admin_branches_path, notice: "Branch successfully deleted.", status: :see_other
    end

    private

    def set_branch
      @branch = Branch.find(params[:id])
    end

    def branch_params
      params.require(:branch).permit(:city)
    end

    def authorize_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
  end
end
