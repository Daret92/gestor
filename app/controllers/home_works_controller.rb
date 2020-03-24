class HomeWorksController < ApplicationController
  before_action :set_home_work, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /home_works
  # GET /home_works.json
  def index
    if current_user.super_user or current_user.rol.nombre == "Gerente"
      @home_works = HomeWork.all().order('id DESC')
    else 
      if current_user.rol.nombre == "JefeDepartamento"
        @home_works = HomeWork.where(administrador:current_user).order('id DESC')
      else
        @home_works = HomeWork.where(usuario:current_user).order('id DESC')
      end
    end
  end

  # GET /home_works/1
  # GET /home_works/1.json
  def show
  end

  # GET /home_works/new
  def new
    @home_work = HomeWork.new
  end

  # GET /home_works/1/edit
  def edit
  end

  def closeWorkHome
    @home_works = HomeWork.find(params[:ids])
    @home_works.resultado = params[:resultado]
    @home_works.finalizado = true;
    if @home_works.save
      render json:{success:true,status:200}
    else
      render json:{success:false,status:500}
    end
  end

  # POST /home_works
  # POST /home_works.json
  def create
    @home_work = HomeWork.new(home_work_params)
    @home_work.administrador_id = current_user.id
    @home_work.finalizado = false    
    respond_to do |format|
      if @home_work.save
        sendNotificacion(@home_work)
        format.html { redirect_to @home_work, notice: 'Tarea guardada correctamente' }
        format.json { render :show, status: :created, location: @home_work }
        format.js {render :show, notice: 'Ingreso Correcto'}
      else
        format.html { render :new }
        format.json { render json: @home_work.errors, status: :unprocessable_entity }
        format.js {render :json, status: :created, notice: 'Ocurrio un error'}
      end
    end
  end

  # PATCH/PUT /home_works/1
  # PATCH/PUT /home_works/1.json
  def update
    respond_to do |format|
      if @home_work.update(home_work_params)
        format.html { redirect_to @home_work, notice: 'Home work was successfully updated.' }
        format.json { render :show, status: :ok, location: @home_work }
      else
        format.html { render :edit }
        format.json { render json: @home_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /home_works/1
  # DELETE /home_works/1.json
  def destroy
    @home_work.destroy
    respond_to do |format|
      format.html { redirect_to home_works_url, notice: 'Home work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sendNotificacion(item)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    begin
      Telegram.bot.send_message(chat_id: item.usuario.token_msj, text: "Se te asigno la tarea \n- "+item.descripcion+"-|nPara el proyecto "+item.proyecto.titulo+"\npara el periodo de "+item.limite+"\n<a href='http://g.tuperfil.com.mx/home_works/"+item.id.to_s+"'>Revisar Tarea</a>",parse_mode: "HTML")
    rescue 
      puts("None")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home_work
      @home_work = HomeWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_work_params
      params.require(:home_work).permit(:proyecto_id, :usuario_id, :descripcion, :urgente, :limite,:finalizado,:resultado)
    end
end
