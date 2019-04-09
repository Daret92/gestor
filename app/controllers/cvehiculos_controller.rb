class CvehiculosController < ApplicationController
  before_action :set_cvehiculo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /cvehiculos
  # GET /cvehiculos.json
  def index
    @cvehiculos = Cvehiculo.all()
  end

  # GET /cvehiculos/1
  # GET /cvehiculos/1.json
  def show
  end

  # GET /cvehiculos/new
  def new
    @cvehiculo = Cvehiculo.new
  end

  # GET /cvehiculos/1/edit
  def edit
  end

  # POST /cvehiculos
  # POST /cvehiculos.json
  def create
    @cvehiculo = Cvehiculo.new(cvehiculo_params)

    respond_to do |format|
      if @cvehiculo.save
        format.html { redirect_to @cvehiculo, notice: 'Cvehiculo was successfully created.' }
        format.json { render :show, status: :created, location: @cvehiculo }
      else
        format.html { render :new }
        format.json { render json: @cvehiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cvehiculos/1
  # PATCH/PUT /cvehiculos/1.json
  def update
    respond_to do |format|
      if @cvehiculo.update(cvehiculo_params)
        format.html { redirect_to @cvehiculo, notice: 'Cvehiculo was successfully updated.' }
        format.json { render :show, status: :ok, location: @cvehiculo }
      else
        format.html { render :edit }
        format.json { render json: @cvehiculo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cvehiculos/1
  # DELETE /cvehiculos/1.json
  def destroy
    @cvehiculo.destroy
    respond_to do |format|
      format.html { redirect_to cvehiculos_url, notice: 'Cvehiculo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cvehiculo
      @cvehiculo = Cvehiculo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cvehiculo_params
      params.require(:cvehiculo).permit(:titulo, :descripcion, :activo)
    end
end
