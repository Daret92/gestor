class DasboardController < ApplicationController
  def index
    @homework = HomeWork.new
  	@registry = Registry.new
  	
  	if current_user.super_user or current_user.rol.nombre == "Gerente"
      @solicitudes = Solicitud.where(estado:"1")
      @all_solicitudes = Solicitud.all()
      @tareas = HomeWork.where(finalizado:false)
      @lastRegistry = Registry.all().limit(5).order('created_at ASC')
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

        @tareas = HomeWork.where(administrador:current_user,finalizado:false)
        usuarios = User.where(users_id:current_user.id)
        @lastRegistry = Registry.where(user:usuarios.ids).limit(5).order('created_at ASC')
      elsif @permissions_user.include?("Bitacora")        
        usuarios = User.where(users_id:current_user.id)
        @lastRegistry = Registry.where(user:usuarios.ids).limit(5).order('created_at ASC')
      else
        @solicitudes = Solicitud.where(user:current_user,estado:"1")
        @tareas = HomeWork.where(usuario:current_user,finalizado:false)
        @lastRegistry = Registry.where(user:current_user).limit(5).order('id DESC')
      end
    end
  end
  def dasboard
  end
end