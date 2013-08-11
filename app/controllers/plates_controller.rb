class PlatesController < ApplicationController
  before_action :set_plate, only: [:show, :edit, :update, :destroy]

  # GET /plates/new
  def new
    @plate = Plate.new
  end

  # GET /plates/1/edit
  def edit
  end

  # POST /plates
  # POST /plates.json
  def create
    @plate = Plate.where(number: plate_params[:number], phone: plate_params[:phone], state: plate_params[:state]).first_or_create
    respond_to do |format|
      if @plate.save
        format.html { redirect_to @plate, notice: 'Plate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @plate }
      else
        format.html { render action: 'new' }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plates/1
  # DELETE /plates/1.json
  def destroy
    @plate.destroy
    respond_to do |format|
      format.html { redirect_to plates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plate
      @plate = Plate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plate_params
      params.require(:plate).permit(:state, :number, :phone)
    end
end
