class PlatesController < ApplicationController
  before_action :set_plate, only: [:show, :edit, :update, :destroy]

  # GET /plates/new
  def new
    @plate = Plate.new
    @plate.state = "CA"
  end

  # GET /plates/1/edit
  def edit
  end

  def lookup
    @plate = Plate.new(:number => params[:number], :state => params[:state])
    respond_to do |format|
      format.json do 
        render json: {
          number: @plate.number,
          state: @plate.state,
          tickets: @plate.raw_tickets
        }
      end
      format.html { render action: 'show' }
    end
  end

  # POST /plates
  # POST /plates.json
  def create
    phone = plate_params[:phone]
    phone = phone.gsub(/[^\d]/,"")[-10..-1]
    @plate = Plate.where(number: plate_params[:number], phone: phone, state: plate_params[:state]).first_or_create
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
