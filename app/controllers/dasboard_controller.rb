class DasboardController < ApplicationController
  def index
  	@registry = Registry.new
  	@lastRegistry = Registry.where(user:current_user).limit(5)
  	if current_user.super_user or current_user.rol.nombre == "Gerente"
      @solicitudes = Solicitud.where(estado:"1")
    else  
      rol =  current_user.rol.nombre
      if rol == "JefeDepartamento"
        usuarios = User.where(users_id:current_user.id)
        @solicitudes = Solicitud.where(user:usuarios.ids,estado:"1")
      else
        @solicitudes = Solicitud.where(user:current_user,estado:"1")
      end
    end
  end
  def dasboard
  end
end
