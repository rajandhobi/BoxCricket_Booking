class GroundsController < ApplicationController
  before_action :set_branch  # Ensure branch is set before creating ground

  before_action :set_ground, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :authorize_ground, only: [:edit, :update, :destroy]



  # GET /grounds or /grounds.json
  def index
    @branch = Branch.find(params[:branch_id])
  
    if current_user.has_role?(:superadmin)
      @grounds = @branch.grounds  # Superadmin sees all grounds
    else
      @grounds = @branch.grounds.where(user: current_user)  # Admins only see their own grounds
    end
  end
  

  # GET /grounds/1 or /grounds/1.json
  def show
    
    authorize @ground

  end

  # GET /grounds/new
  def new
    @ground = @branch.grounds.new

    authorize @ground
  end
 

  # GET /grounds/1/edit
  def edit
    @branch = Branch.find(params[:branch_id])
    @ground = @branch.grounds.find(params[:id])
  end

  

  def create
    @ground = @branch.grounds.new(ground_params)
    @ground.user = current_user  # Assign ground to the currently logged-in user    authorize @ground


    respond_to do |format|
      if @ground.save
        format.html { redirect_to branch_ground_path(@branch, @ground), notice: "Ground was successfully created." }
        format.json { render :show, status: :created, location: @ground }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ground.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /grounds/1 or /grounds/1.json
  def update
    authorize @ground

    respond_to do |format|
      if @ground.update(ground_params)
        format.html { redirect_to branch_ground_path(@branch, @ground), notice: "Ground was successfully updated." }
        format.json { render :show, status: :ok, location: @ground }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ground.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grounds/1 or /grounds/1.json
  def destroy
    authorize @ground

    @ground.destroy!


    respond_to do |format|
      format.html { redirect_to branch_path(@branch), status: :see_other, notice: "Ground was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find_by(id: params[:branch_id])
      redirect_to branches_path, alert: "Branch not found" if @branch.nil?
    end

    # def set_ground
    #   @ground = @branch.grounds.find(params[:id]) if @branch
    # end
    def set_ground
      @ground = @branch.grounds.find(params[:id])
    
      # Ensure only superadmins or the ground's owner can access it
      if current_user.has_role?(:superadmin) || @ground.user == current_user
        @ground
      else
        redirect_to branch_grounds_path(@branch), alert: "You are not authorized to access this ground."
      end
    end
    

    def authorize_ground
      authorize @ground
    end
    

    # Only allow a list of trusted parameters through.
    def ground_params
      params.require(:ground).permit(
        :name, :location, :city, :state, :country, :pincode, 
        :capicity, :open_time, :close_time, 
        :facility, :contact_number, :email, :description, :branch_id,:image,
        slots_attributes: [:id, :start_time, :end_time, :price, :_destroy]
      )
    end
    
end
