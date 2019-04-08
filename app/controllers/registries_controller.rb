class RegistriesController < ApplicationController
  before_action :set_registry, only: [:show, :edit, :update, :destroy]

  # GET /registries
  # GET /registries.json
  def index
    if current_user.super_user or current_user.rol.nombre == "Gerente"
      @registries = Registry.all()
    else  
      rol =  current_user.rol.nombre
      if rol == "JefeDepartamento"
        usuarios = User.where(users_id:current_user.id)
        @registries = Registry.where(user:usuarios.ids)
      else
        @registries = Registry.where(user:current_user)
      end
    end
  end

  # GET /registries/1
  # GET /registries/1.json
  def show
  end

  # GET /registries/new
  def new
    @registry = Registry.new
  end

  # GET /registries/1/edit
  def edit
  end

  # POST /registries
  # POST /registries.json
  def create
    @registry = Registry.new(registry_params)
    @registry.user = current_user
    @registry.finalizado = true
    respond_to do |format|
      if @registry.save
        format.html { redirect_to @registry, notice: 'Registry was successfully created.' }
        format.json { render :show, status: :created, location: @registry }
        format.js {render :show, notice: 'Ingreso Correcto'}
      else
        format.html { render :new }
        format.json { render json: @registry.errors, status: :unprocessable_entity }
        format.js {render :json, status: :created, notice: 'Ocurrio un error'}
      end
    end
  end

  # PATCH/PUT /registries/1
  # PATCH/PUT /registries/1.json
  def update
    respond_to do |format|
      if @registry.update(registry_params)
        format.html { redirect_to @registry, notice: 'Registry was successfully updated.' }
        format.json { render :show, status: :ok, location: @registry }
      else
        format.html { render :edit }
        format.json { render json: @registry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registries/1
  # DELETE /registries/1.json
  def destroy
    @registry.destroy
    respond_to do |format|
      format.html { redirect_to registries_url, notice: 'Registry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registry
      @registry = Registry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registry_params
      params.require(:registry).permit(:proyecto_id, :user_id, :titulo, :descripcion, :resultado, :finalizado)
    end
end
