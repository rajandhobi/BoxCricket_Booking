class Admin::GroundsController < ApplicationController
  before_action :set_branch, only: %i[index new create]
  before_action :set_ground, only: %i[edit update destroy]

  def index
    @grounds = @branch.grounds
  end

  def new
    @ground = @branch.grounds.new
  end

  def create
    @ground = @branch.grounds.new(ground_params)
    if @ground.save
      redirect_to admin_branch_grounds_path(@branch), notice: 'Ground added successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @ground.update(ground_params)
      redirect_to admin_branches_path, notice: 'Ground updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @ground.destroy
    redirect_to admin_branches_path, notice: 'Ground deleted successfully!'
  end

  private

  def set_branch
    @branch = Branch.find_by(id: params[:branch_id])
  end

  def set_ground
    @ground = Ground.find(params[:id])
  end

  def ground_params
    params.require(:ground).permit([ :name, :location, :city, :state, :country, :pincode, :ground_type, :capicity, :price_per_hour, :availabiity, :open_time, :close_time, :facility, :contact_number, :email, :description, :branch_id ])
  end
end
