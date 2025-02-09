class Admin::SlotsController < ApplicationController
  before_action :set_ground, only: %i[index new create]
  before_action :set_slot, only: %i[edit update destroy]

  def index
    @slots = @ground.slots
  end

  def new
    @slot = @ground.slots.new
  end

  def create
    @slot = @ground.slots.new(slot_params)
    if @slot.save
      redirect_to admin_ground_slots_path(@ground), notice: 'Slot created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @slot.update(slot_params)
      redirect_to admin_branches_path, notice: 'Slot updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @slot.destroy
    redirect_to admin_branches_path, notice: 'Slot deleted successfully!'
  end

  private

  def set_ground
    @ground = Ground.find(params[:ground_id])
  end

  def set_slot
    @slot = Slot.find(params[:id])
  end

  def slot_params
    params.require(:slot).permit(:start_time, :end_time, :price, :availability)
  end
end
