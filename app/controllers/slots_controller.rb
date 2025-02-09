class SlotsController < ApplicationController
  before_action :set_ground
  before_action :set_slot, only: %i[show edit update destroy]
  before_action :authenticate_user!
  # before_action :authorize_slot, only: [:edit, :update, :destroy]

  # GET /grounds/:ground_id/slots
  def index
    @slots = @ground.slots
  end

  # GET /grounds/:ground_id/slots/:id
  def show
  end

  # GET /grounds/:ground_id/slots/new
  def new
    @branch = Branch.find(params[:branch_id])
    @ground = @branch.grounds.find(params[:ground_id])
    @slot = @ground.slots.new
    authorize @slot
  end

  # GET /grounds/:ground_id/slots/:id/edit
  def edit
    @branch = Branch.find_by(id: params[:branch_id])
    unless @branch
      redirect_to branches_path, alert: "Branch not found"
      return
    end
  
    @ground = @branch.grounds.find_by(id: params[:ground_id])
    unless @ground
      redirect_to branch_path(@branch), alert: "Ground not found"
      return
    end
  
    @slot = @ground.slots.find_by(id: params[:id])
    unless @slot
      redirect_to branch_ground_path(@branch, @ground), alert: "Slot not found"
      return
    end
  end
  

  # POST /grounds/:ground_id/slots
  def create
    @slot = @ground.slots.new(slot_params)
    authorize @slot
  
    if @slot.save
      redirect_to ground_path(@ground), notice: "Slot was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  # PATCH/PUT /grounds/:ground_id/slots/:id
  def update
    set_slot # Ensure @slot is set before authorization
    if @slot.nil?
      redirect_to branch_ground_slots_path(@branch, @ground), alert: "Slot not found"
      return
    end
  
    authorize @slot
  
    if @slot.update(slot_params)
      redirect_to branch_ground_slot_path(@branch, @ground, @slot), notice: "Slot was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end
  

  # DELETE /grounds/:ground_id/slots/:id
  def destroy
    @slot = @ground.slots.find(params[:id])
    authorize @slot

    @slot.destroy
    flash[:notice] = "Slot successfully deleted"
    redirect_to branch_ground_slots_path(@branch, @ground)
  end
  
  private


  def set_slot
    @branch = Branch.find_by(id: params[:branch_id])
    unless @branch
      redirect_to branches_path, alert: "Branch not found"
      return
    end
  
    @ground = @branch.grounds.find_by(id: params[:ground_id])
    unless @ground
      redirect_to branch_path(@branch), alert: "Ground not found"
      return
    end
  
    @slot = @ground.slots.find_by(id: params[:id])
    unless @slot
      redirect_to branch_ground_path(@branch, @ground), alert: "Slot not found"
      return
    end
  end
  

  def set_ground
    @branch = Branch.find_by(id: params[:branch_id])
    unless @branch
      redirect_to branches_path, alert: "Branch not found" and return
    end
  
    @ground = @branch.grounds.find_by(id: params[:ground_id])
    unless @ground
      redirect_to branch_path(@branch), alert: "Ground not found" and return
    end
  end
  
  
  
  
  
  

  # def authorize_slot
  #   authorize @slot
  # end

  def slot_params
    params.require(:slot).permit(:start_time, :end_time, :price)
  end
end
