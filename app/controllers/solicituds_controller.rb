class SolicitudsController < ApplicationController
  before_action :set_solicitud, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /solicituds
  # GET /solicituds.json
  def index
    if current_user.super_user or current_user.rol.nombre == "Gerente"
      @solicituds = Solicitud.all().order('id DESC')
    else  
      rol =  current_user.rol.nombre
      if rol == "JefeDepartamento"
        
        users = User.where(users_id:current_user.id)
        @solicituds = Solicitud.where(user_id:users.ids).order('id DESC')
      else
        @solicituds = Solicitud.where(user:current_user).order('id DESC')
      end
    end

  end

  # GET /solicituds/1
  # GET /solicituds/1.json
  def show
    @solicitudes_arr = []
    @solicitud.solicitud_users.each do |item|
      if item.user_id != @solicitud.user.id
        @solicitudes_arr.push(item.user_id)
      end
    end
  end

  # GET /solicituds/new
  def new
    @solicitud = Solicitud.new
  end

  # GET /solicituds/1/edit
  def edit
    @edit = false
    
  end

  def update_materials
    material = Material.find(params[:ids])
    if material.autorizado == true
      material.autorizado = false
    else
      material.autorizado = true
    end
    respond_to do |format|
      if material.save
        apps = {'success': true}
        format.json { render json: apps, status: 200 }
      else
        render json: { status: :unprocessable_entity }
      end
    end
  end

  def update_viaticos
    viatico = Viatico.find(params[:ids])
    if viatico.autorizada == true
      viatico.autorizada = false
    else
      viatico.autorizada = true
    end
    respond_to do |format|
      if viatico.save
        apps = {'success': true}
        format.json { render json: apps, status: 200 }
      else
        render json: { status: :unprocessable_entity }
      end
    end
  end

  def authSolicitud
    solicitud = Solicitud.find(params['ids'])
    solicitud.estado='2'
    respond_to do |format|
      if solicitud.save
        sendto_users(solicitud)
        format.html { redirect_to solicitud, notice: 'Solicitud was successfully validate.' }
      else
        render json: { status: :unprocessable_entity }
      end
    end
  end

  def finSolicitud
  solicitud = Solicitud.find(params['ids'])
  solicitud.estado='3'
    respond_to do |format|
      if solicitud.save
        fin_solicituds(solicitud)
        format.html { redirect_to solicitud, notice: 'Solicitud was successfully validate.' }
      else
        render json: { status: :unprocessable_entity }
      end
    end
  end

  def cancSolicitud
    solicitud = Solicitud.find(params['ids'])
    solicitud.estado='4'
    respond_to do |format|
      if solicitud.save
        cancel_sol(solicitud)
        format.html { redirect_to solicitud, notice: 'Solicitud was successfully Cancel.' }
      else
        render json: { status: :unprocessable_entity }
      end
    end
    
  end
  def validate_materials
    material = Material.find(params[:ids])
    if material.entregado == true
      material.entregado = false
    else
      material.entregado = true
    end
    respond_to do |format|
      if material.save
        apps = {'success': true}
        format.json { render json: apps, status: 200 }
      else
        render json: { status: :unprocessable_entity }
      end
    end
  end

  # POST /solicituds
  # POST /solicituds.json
  def create
    @solicitud = Solicitud.new(solicitud_params)
    @solicitud.user = current_user
    if ['Gerente','JefeDepartamento'].include?(current_user.rol.nombre)
      @solicitud.estado = "2"
    else
      @solicitud.estado = "1"
    end
    respond_to do |format|
      if @solicitud.save
        sols = SolicitudUser.new(user:current_user,solicitud_id:@solicitud.id)
        sols.save
        not_jefe(@solicitud)
        format.html { redirect_to @solicitud, notice: 'Solicitud was successfully created.' }
        format.json { render :show, status: :created, location: @solicitud }
      else
        format.html { render :new }
        format.json { render json: @solicitud.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solicituds/1
  # PATCH/PUT /solicituds/1.json
  def update
    respond_to do |format|
      if @solicitud.update!(solicitud_params)
        format.html { redirect_to @solicitud, notice: 'Solicitud was successfully updated.' }
        format.json { render :show, status: :ok, location: @solicitud }
      else  
        format.html { render :edit }
        format.json { render json: @solicitud.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solicituds/1
  # DELETE /solicituds/1.json
  def destroy
    @solicitud.estado="4"
    @solicitud.save
    cancel_sol(@solicitud)
    respond_to do |format|
      format.html { redirect_to solicituds_url, notice: 'Solicitud was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  def sendto_users(solicitud)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    if !current_user.super_user
      solicitud.solicitud_users.each do |item|
        begin
          Telegram.bot.send_message(chat_id: item.user.token_msj, text: "Se ha autorizado la solicitud "+solicitud.id.to_s+", Para el proyecto "+solicitud.proyecto.titulo+"\n" +"<a href='http://gestor.tuperfil.com.mx/solicituds/"+solicitud.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
        rescue
          sendNotificacion("Autorizacion","Se ha autorizado la solicitud "+solicitud.id.to_s+", Para el proyecto "+solicitud.proyecto.titulo,item.user.token_msj)
        end
      end
    end
  end

  def fin_solicituds(solicitud)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    if !current_user.super_user 
      begin
        Telegram.bot.send_message(chat_id: solicitud.user.token_msj, text: "Se Finalizo la solicitud "+solicitud.id.to_s+", Para el proyecto "+solicitud.proyecto.titulo+"\n<a href='http://gestor.tuperfil.com.mx/solicituds/"+solicitud.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
        rescue
        sendNotificacion("Entregada","Se Finalizo la solicitud "+solicitud.id.to_s+", Para el proyecto "+solicitud.proyecto.titulo,solicitud.user.token_msj)
      end
    end
  end

  def cancel_sol(solicitud)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    if !current_user.super_user
      begin
        Telegram.bot.send_message(chat_id: solicitud.user.token_msj, text: "Se Cancelo la solicitud "+solicitud.id.to_s+", Para el proyecto "+solicitud.proyecto.titulo+"\n<a href='http://gestor.tuperfil.com.mx/solicituds/"+solicitud.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
      rescue
        sendNotificacion("Cancelado","Se Cancelo la solicitud "+solicitud.id.to_s+", Para el proyecto "+solicitud.proyecto.titulo,solicitud.user.token_msj)
      end
    end
  end


  def not_jefe(validato)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    if validato.user.users_id 
      jefe = User.find(validato.user.users_id)
    else
      jefe = false
    end

    contenido = ""
    if validato.materials.count > 0
     contenido = contenido + "Materiales : "+validato.materials.count.to_s+ "\n"
    end
    if validato.vehiculos.count >0 
      contenido = contenido+ "Vehiculo : "+validato.vehiculos.count.to_s + "\n"
    end
    if validato.viaticos.count >0 
      contenido = contenido+ "Viaticos : "+validato.viaticos.count.to_s + "\n"
    end
    if validato.otro.count >0 
      contenido = contenido+ "Otros : "+validato.otro.count.to_s + "\n"
    end
    if validato.estado == "2"
      contenido = contenido +"\n Solicitud Autorizada"
    end
    if jefe
      begin
        Telegram.bot.send_message(chat_id: jefe.token_msj, text: "Genero una solicitud "+validato.user.nombre+", Para el proyecto "+validato.proyecto.titulo+"\nContenido de la solicitud:\n"+ contenido+"\n" +"<a href='http://gestor.tuperfil.com.mx/solicituds/"+validato.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
      rescue 
        sendNotificacion("Genero Solicitud","Genero una solicitud "+validato.user.nombre+", con folio: "+validato.id.to_s+", Para el proyecto "+validato.proyecto.titulo+"\nContenido de la solicitud:\n"+ contenido,jefe.token_msj)
      end
    else
      Telegram.bot.send_message(chat_id: 340614248, text: "Genero una solicitud "+validato.user.nombre+", Para el proyecto "+validato.proyecto.titulo+"\nContenido de la solicitud:\n"+ contenido+"\n" +"No se envio a un supervisor favor de realizar el aviso a quien corresponde",parse_mode: "HTML")
    end
  end

  def sendNotificacion(titulo,cuerpo,ids)
    fcm = FCM.new("AAAAuSfCQSQ:APA91bG7tfzvuY0_Zf7IXDlooCI8BMESA516GsCnL5mVXkc92Yb2vr80ru3tCzmG0zUT-dZKwEm3H7OFSNSIR38ZoVUnx9sNW79fubU0sLWfIrMwJlz0DursXd0GOH01mViSvpteGTmM")
    registration_ids= [ids]
    options = { "notification": {
              "title": titulo,
              "body": cuerpo
          },
          "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "id": "1", "status": "done"}
    }
    response = fcm.send(registration_ids, options)
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solicitud
      @solicitud = Solicitud.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solicitud_params
      params.require(:solicitud).permit(:id,:proyecto_id, :estado, :observaciones, otro_attributes: Otro.attribute_names.map(&:to_sym).push(:_destroy),materials_attributes: Material.attribute_names.map(&:to_sym).push(:_destroy),solicitud_users_attributes: SolicitudUser.attribute_names.map(&:to_sym).push(:_destroy),viaticos_attributes: Viatico.attribute_names.map(&:to_sym).push(:_destroy),vehiculos_attributes:Vehiculo.attribute_names.map(&:to_sym).push(:_destroy))
    end
end
