class ApiAppController < ApplicationController
  def login
		if !params[:email].empty? and !params[:pass].empty?
			user = User.find_by_email(params[:email])
			if !user.nil?
				if user.valid_password?(params[:pass])
					user.auth_token = params[:tokenFire]
					user.save
					result = true
					
					if user.rol
						rols = user.rol.nombre
					else
						rols = "sin rol"
					end
					apps = {response:[ 'email': user.email,'password': params[:pass],'superUser': user.super_user, 'rol': rols],success: ['success':result] }

		  		render json: {users:apps} 

			  else
			  	result = false
					apps = {success:['success': result] }
					render json: { users:apps,status: :unprocessable_entity }
				end
			else
				result = false
				apps = {success:['success': result] }
				render json: { users:apps,status: :unprocessable_entity }
			end
		else
			result = false
			apps = {registro:[success: result,error:"no logeo"]}
			render json: {response:apps}
		end
  end

  def get_users
  	users = User.where(super_user:false,activo:true).order('nombre ASC')
  	proyecto = Proyecto.where(estado:"1")
  	apps = []
  	pro_arr = []
  	users.each do |item|  		
  		apps.push({id:item.id,email: item.email, rol: item.rol.nombre, equipo:EquipoUser(item)})
  	end
  	proyecto.each do |item|
  		pro_arr.push({id:item.id,titulo:item.titulo})
  	end
  	render json: {users:apps,proyecto:pro_arr}
  end

  def gps_save
  	if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
			if user.valid_password?(params[:password])
				proyecto = Proyecto.find(params['proyecto'].split(",")[0])
				@gps = GpsSave.new
				@gps.latitud = params[:latitud]
				@gps.longitud = params[:longitud]
				@gps.proyecto = proyecto
				@gps.user = user
				if @gps.save
					result = true
					apps = {response:[ 'Folio': @gps.id,'success':result] }
	  			render json: {result:apps} 
				else
					result = false
					apps = {response:['success': result] }
					render json: { result:apps,status: :unprocessable_entity }
				end
				
			else
				result = false
				apps = {response:['success': result] }
				render json: { result:apps,status: :unprocessable_entity }
			end
		else
			result = false
			apps = {response:['success': result] }
			render json: { result:apps,status: :unprocessable_entity }
		end
  end


  def EquipoUser(users)
		@teams = Equipo.where(user:users)
		@deps  = EquipoUsuario.where(user:users)
		if @teams.size > 0
			tmp = ""
			@teams.each do |item|
				tmp = users.nombre+" "+users.apellido+", Encargado de: "+item.nombre
			end
			return tmp.html_safe
		else
			tmp = ""
			if @deps.size > 0
				@deps.each do |item|
					tmp = users.nombre+" "+users.apellido+", Pertenece a "+item.equipo.nombre 
				end
				return tmp.html_safe
			else
				return users.nombre+" "+users.apellido+", Sin Equipo de Trabajo"
			end
		end
	end

	def save_sold
		user = User.find_by_email(params[:user])
		if user.valid_password?(params[:password])
			proyecto = Proyecto.find(params['proyecto'].split(",")[0])
			
			@solicitud = Solicitud.new
			
			@solicitud.user = user
			@solicitud.proyecto = proyecto
			@solicitud.estado =	"1"
			@solicitud.observaciones = params[:observa]

			materiales = ActiveSupport::JSON.decode(params[:material])
			involucrados = ActiveSupport::JSON.decode(params[:involucrados])
			
			if @solicitud.save
				if materiales.length > 0
					materiales.each do |item|
						@material = Material.new
						@material.cantidad = item['cantidad']
						@material.material = item['material']
						@material.descripcion = item['detalles']
						@material.solicitud = @solicitud
						@material.save
					end
				end

				if params[:otro] != ""
					@otro = Otro.new
					@otro.descripcion = params[:otro]
					@otro.solicitud = @solicitud
					@otro.save
				end

				if params[:vehiculo] != "" && params[:Ovehiculo] != ""
					@vehiculo = Vehiculo.new
					@vehiculo.solicitud = @solicitud
					@vehiculo.vehiculo = params[:vehiculo]
					@vehiculo.descripcion = params[:Ovehiculo]
					@vehiculo.save
				end

				if params[:cViatico] != "" && params[:dViatico] != ""
					@viatico = Viatico.new
					@viatico.cantidad = params[:cViatico]
					@viatico.descripcion = params[:dViatico]
					@viatico.solicitud = @solicitud
					@viatico.save
				end

				if involucrados.length > 0
					involucrados.each do |item|
						sols = SolicitudUser.new
						sols.solicitud = @solicitud
						sols.user = User.find_by_email(item)
						sols.save
					end
					sols = SolicitudUser.new
					sols.solicitud = @solicitud
					sols.user = user
					sols.save
				end
				not_jefe(@solicitud)
				result = true
				apps = {solicitud:[ 'Folio': @solicitud.id,success: result]}
  			render json: {response:apps} 
			else
				result = false
				apps = {solicitud:[success: result]}
  			render json: {response:apps} 
			end
		else
			result = false
			apps = {solicitud:[success: result]}
			render json: {response:apps} 
		end
	end

	def updateMaterial
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@material = Material.find(params[:id])
			if @material.solicitud.user == user or user.rol.nombre == "Gerente" or @material.solicitud.user.users_id == user.users_id
				@material.cantidad = params[:cantidad]
				@material.descripcion = params[:descripcion]
				@material.material = params[:material]
				if @material.save
					result = true
					apps = {material:[ 'Folio': @material.id,'cantidad': @material.cantidad,'descripcion': @material.descripcion,'material': @material.material,success: result]}
		  		render json: {response:apps} 
				else
					result = false
					apps = {material:[success: result]}
					render json: {response:apps} 
				end
			else
					result = false
					apps = {material:[success: result]}
					render json: {response:apps} 
				end
		else
			result = false
			apps = {material:[success: result]}
			render json: {response:apps} 
		end
		
	end


	def removeMaterial
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@material = Material.find(params[:id])
			@solicitud = Solicitud.find(@material.solicitud_id)
			if @material.solicitud.user == user or user.rol.nombre == "Gerente" or @material.solicitud.user.users_id == user.users_id
				if @material.destroy
					result = true
					apps = {material:[success: result]}
		  		render json: {response:apps} 
				else
					result = false
					apps = {material:[success: result]}
					render json: {response:apps} 
				end
			else
				result = false
				apps = {material:[success: result]}
				render json: {response:apps} 
			end
		else
			result = false
			apps = {material:[success: result]}
			render json: {response:apps} 
		end
		
	end

	def saveMaterial
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@solicitud = Solicitud.find(params[:id])
			if @solicitud.user == user or user.rol.nombre == "Gerente" or @solicitud.user.users_id == user.users_id
				@material = Material.new
				@material.cantidad = params[:cantidad]
				@material.descripcion = params[:descripcion]
				@material.material = params[:material]
				@material.solicitud = @solicitud
				if @material.save
					result = true
					apps = {material:[ 'id': @material.id,'cantidad': @material.cantidad,'descripcion': @material.descripcion,'material': @material.material,success: result]}
		  		render json: {response:apps} 
				else
					result = false
					apps = {material:[success: result]}
					render json: {response:apps} 
				end
			else
				result = false
				apps = {material:[success: result]}
				render json: {response:apps} 
			end
		else
			result = false
				apps = {material:[success: result]}
				render json: {response:apps} 
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
      		Telegram.bot.send_message(chat_id: jefe.token_msj, text: "Genero una solicitud "+validato.user.nombre+", Para el proyecto "+validato.proyecto.titulo+"\nContenido de la solicitud:\n"+ contenido+"\n" +"<a href='http://35.196.76.142/solicituds/"+validato.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
      	rescue
      		print("none")
      	end
      	begin
      		sendNotificacion("Genero Solicitud","Genero una solicitud "+validato.user.nombre+", Para el proyecto "+validato.proyecto.titulo+"\nContenido de la solicitud:\n"+ contenido,jefe.auth_token)
      	rescue
      		print("None")
      	end
    else
      Telegram.bot.send_message(chat_id: 340614248, text: "Genero una solicitud "+validato.user.nombre+", Para el proyecto "+validato.proyecto.titulo+"\nContenido de la solicitud:\n"+ contenido+"\n" +"No se envio a un supervisor favor de realizar el aviso a quien corresponde",parse_mode: "HTML")
    end
    begin
		notif = Notificacion.new
		notif.user = jefe
		notif.texto = "Nueva Solicitud generada con folio"+solicitud.id.to_s
		notif.leido = false
		notif.tipo = "1"
		notif.save
	rescue 
		print("None")
	end
  end

  def save_registre
  	user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			proyecto = Proyecto.find(params['proyecto'].split(",")[0])

		  	@registro = Registry.new
		  	@registro.proyecto = proyecto
		  	@registro.user = user
		  	@registro.titulo = params[:titulo]
		  	@registro.descripcion = params[:detalles]
		  	@registro.resultado = params[:resultado]
		  	@registro.finalizado = true
		  	if @registro.save
				result = true
				apps = {registro:[ 'Folio': @registro.id,success: result]}
				render json: {response:apps} 
			else
				result = false
				apps = {registro:[success: result]}
				render json: {response:apps} 
			end
		else
			result = false
			apps = {registro:[success: result]}
			render json: {response:apps} 
		end
	end

	def get_allR
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@registro = Registry.where(user:user)
			apps =[]
			@registro.each do |item|
				apps.push({proyecto:item.proyecto.titulo, titulo:item.titulo, descripcion: item.descripcion,resultado:item.resultado,fecha:item.created_at.to_formatted_s(:long).to_s})
			end
			result = [success:true]
				
			render json: {response:apps,success: result} 
		else
			result = false
			apps = {registro:[success: result]}
			render json: {response:apps} 
		end

	end

	def save_bitacora
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			proyecto = Proyecto.find(params['proyecto'].split(",")[0])
			@bitacora = Bitacora.new
			@bitacora.proyecto = proyecto
			@bitacora.user = user
			@bitacora.nota = params['nota']
			if @bitacora.save
				result = true
				apps = {registro:[ 'Folio': @bitacora.id,success: result]}
				render json: {response:apps} 
			else
				result = false
				apps = {registro:[success: result]}
				render json: {response:apps}
			end
		else
			result = false
			apps = {registro:[success: result]}
			render json: {response:apps}
		end
	end

	def get_bitacora
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			proyecto = Proyecto.find(params['proyecto'].split(",")[0])
			@bitacora = Bitacora.where(proyecto:proyecto).order('id DESC')
			apps =[]
			@bitacora.each do |item|
		  	apps.push({id:item.id,proyecto: item.proyecto.titulo, nota:item.nota,fecha:item.created_at.to_formatted_s(:long).to_s,usuario: item.user.nombre})
		  end
			result = true
			render json: {response:apps} 
			
		else
			result = false
			apps = {registro:[success: result]}
			render json: {response:apps}
		end
	end

	def getSolicitudsTeam
		user = User.find_by_email(params[:user])
		if user.valid_password?(params[:password])
			
			proyecto = Proyecto.find(params[:proyecto].split(",")[0])
			@equipo = EquipoUsuario.where(user:user).first()
			if(!@equipo.nil?)
				@usuariosEquipo = EquipoUsuario.where(equipo:@equipo.equipo)
				@solicitudes = Solicitud.where(user:@usuariosEquipo.ids,proyecto:proyecto).order('id DESC')
			elsif user.super_user == true
			
				@solicitudes = Solicitud.where(proyecto:proyecto).order('id DESC')
			
			elsif (!user.rol.nil?)
				if(user.rol.nombre == "Gerente")
					@usuariosEquipo = User.where(users_id:user.id)
					ids =[]
					@usuariosEquipo.each do |item| 
						if !ids.include?(item.id)
							ids.append(item.id)
						end
					end
					if !ids.include?(user.id)
						ids.append(user.id)		
					end
					@solicitudes = Solicitud.where(user:ids,proyecto:proyecto).order('id DESC')
				else
					@solicitudes = Solicitud.where(user:user,proyecto:proyecto).order('id DESC')
				end
			
			else
			
				@solicitudes = Solicitud.where(user:user,proyecto:proyecto).order('id DESC')
			end

			if(@solicitudes.length > 0)
				apps=[]

				@solicitudes.each do |item|
					materials=[]
					if(item.materials.count > 0)
						item.materials.each do |sitem|
							materials.push({id:sitem.id,cantidad:sitem.cantidad,material:sitem.material,descripcion:sitem.descripcion})
						end
					end

					viaticos=[]
					if(item.viaticos.count > 0)
						item.viaticos.each do |sitem|
							viaticos.push({id:sitem.id,cantidad:sitem.cantidad,detalles:sitem.descripcion})
						end
					end

					otro=[]
					if(item.otro.count > 0)
						item.otro.each do |sitem|
							otro.push({id:sitem.id,descripcion:sitem.descripcion})
						end
					end
					vehiculos=[]
					if(item.vehiculos.count > 0)
						item.vehiculos.each do |sitem|
							vehiculos.push({id:sitem.id,vehiculo:sitem.vehiculo,descripcion:sitem.descripcion})
						end
					end

					involucra=[]
					involucrados = SolicitudUser.where(solicitud: item)
					involucrados.each do |sitem|
						involucra.push({id:sitem.id,usuario:sitem.user.email+" "+EquipoUser(sitem.user)})
					end

					estado = "Cancelada"
					if(item.estado == "1")
						estado = "Abierta"
					elsif(item.estado == "2")
						estado = "Validada"
					elsif(item.estado =="3")
						estado = "Entregada"
					end
			  		apps.push({
			  			id:item.id,
			  			proyecto: item.proyecto.titulo, 
			  			fecha:item.created_at.to_formatted_s(:long).to_s,
			  			usuario: item.user.nombre,
			  			estado:estado,
			  			material: item.materials.count,
			  			vehiculo:item.vehiculos.count,
			  			otro:item.otro.count,
			  			viatico:item.viaticos.count,
			  			materials_arr:materials,
			  			vehiculo_arr:vehiculos,
			  			otro_arr:otro,
			  			viaticos_arr: viaticos,
			  			involucrado_arr:involucra
			  		})
			  end
			  result = [{result: true}]
				render json: {response:apps,result:result} 
			else
				result = [{result: false}]
				render json: {result:result} 
			end	
		else
			result = false
			apps = {registro:[success: result,error:"no logeo"]}
			render json: {response:apps}
		end
	end

	def getNotificacion
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			noticiacion = Notificacion.where(user: user,leido: false)
			if noticiacion.length > 0
				notificaciones_arr = []
				noticiacion.each do |item|
					notificaciones_arr.push({
						id: item.id,
						texto: item.texto,
						tipo: item.tipo
					})
				end
				result = [{result: true}]
				render json: {response:notificaciones_arr,result:result} 
			else
				result = [{result: false}]
				render json: {result:result} 
			end	
		else
			result = false
			apps = {material:[success: result]}
			render json: {response:apps} 
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

end
