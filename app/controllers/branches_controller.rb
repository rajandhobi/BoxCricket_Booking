class BranchesController < ApplicationController
  before_action :authenticate_user!,except: %i[index]
  before_action :set_branch, only: %i[ show edit update destroy ]
  before_action :authorize_branch, only: [:edit, :update, :destroy]


  # GET /branches or /branches.json
  def index
    @branches = Branch.all

    @q = Branch.ransack(params[:q]) # Initialize search object
    @branches = @q.result(distinct: true) # Filter results
  end

  # GET /branches/1 or /branches/1.json
  def show
    @branch = Branch.find(params[:id])
    @grounds = @branch.grounds # Fetch grounds under this branch
  end

  # GET /branches/new
  def new
    @branch = Branch.new
    authorize @branch
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches or /branches.json
  def create
    @branch = current_user.branches.new(branch_params) # Assign current admin as owner
    authorize @branch


    respond_to do |format|
      if @branch.save
        format.html { redirect_to @branch, notice: "Branch was successfully created." }
        format.json { render :show, status: :created, location: @branch }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /branches/1 or /branches/1.json
  def update
    authorize @branch

    respond_to do |format|
      if @branch.update(branch_params)
        format.html { redirect_to @branch, notice: "Branch was successfully updated." }
        format.json { render :show, status: :ok, location: @branch }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @branch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /branches/1 or /branches/1.json
  def destroy
    authorize @branch

    @branch.destroy!

    respond_to do |format|
      format.html { redirect_to branches_path, status: :see_other, notice: "Branch was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    def authorize_branch
      authorize @branch
    end

    # Only allow a list of trusted parameters through.
    def branch_params
      params.require(:branch).permit(:city,:user_id)
    end
end
