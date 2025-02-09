class Admin::BranchesController < ApplicationController
  before_action :set_branch, only: %i[edit update destroy]

  def index
    @branches = Branch.all
  end

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to admin_branches_path, notice: 'Branch created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @branch.update(branch_params)
      redirect_to admin_branches_path, notice: 'Branch updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @branch.destroy
    redirect_to admin_branches_path, notice: 'Branch deleted successfully!'
  end

  private

  def set_branch
    @branch = Branch.find(params[:id])
  end

  def branch_params
    params.require(:branch).permit(:name, :description)
  end
end
