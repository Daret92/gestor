class DasboardController < ApplicationController
  def index
  	@registry = Registry.new
  	@lastRegistry = Registry.where(user:current_user).limit(5).order('id DESC')
  	if current_user.super_user or current_user.rol.nombre == "Gerente"
      @solicitudes = Solicitud.where(estado:"1")
      @all_solicitudes = Solicitud.all()
    else  
      rol =  current_user.rol.nombre
      if rol == "JefeDepartamento"
        userSol = SolicitudUser.where(user: current_user)
        ids = []
        if userSol.size > 0
          userSol.each do |item|
            ids.append(item.solicitud_id)
          end
        end
        @solicitudes = Solicitud.where(id:ids,estado:"1")
      else
        @solicitudes = Solicitud.where(user:current_user,estado:"1")
      end
    end
  end
  def dasboard
  end
end