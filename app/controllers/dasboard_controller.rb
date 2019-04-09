class DasboardController < ApplicationController
  def index
  	@registry = Registry.new
  	@lastRegistry = Registry.where(user:current_user).limit(5)
  	if current_user.super_user or current_user.rol.nombre == "Gerente"
      @solicitudes = Solicitud.where(estado:"1")
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
        @solicitudes = Solicitud.find(ids)
      else
        @solicitudes = Solicitud.where(user:current_user)
      end
    end
  end
  def dasboard
  end
end