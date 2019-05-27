class ApiAdmController < ApplicationController
	def get_users_proyecto
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
			if  user.super_user or user.rol.nombre == "Gerente"
				users = User.where(activo:true,super_user:false)
			else
				users = User.where(users_id:user.id)
			end

		  	proyecto = Proyecto.where(estado:"1")
		  	
		  	apps = []
		  	pro_arr = []

		  	users.each do |item|
		  		apps.push({id:item.id,email: item.email, nombre: item.nombre})
		  	end

		  	proyecto.each do |item|
		  		pro_arr.push({id:item.id,titulo:item.titulo})
		  	end

		  	render json: {users:apps,proyecto:pro_arr}
		else
			result = false
			apps = {success:['success': result] }
			render json: { users:apps,status: :unprocessable_entity }
		end
	end


	def getUbicacionesAdm
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
				
				userUbicacion = User.find(params[:usuario].split(",")[0].to_i)
	
				userProyecto = Proyecto.find(params['proyecto'].split(",")[0].to_i)

		  	
		  	gps = GpsSave.where(user_id:userUbicacion.id,proyecto_id:userProyecto.id).order('id DESC')
		 
		  	gps_arr =[]
		  	gps.each do |item|
		  		gps_arr.push({id:item.id, user: item.user.nombre, proyecto: item.proyecto.titulo, latitud: item.latitud, longitud: item.longitud,update: item.updated_at.to_formatted_s(:short).to_s})
		  	end
		  	result = true
		  	render json: {ubicaciones:gps_arr,success: result}
		else
			result = false
			apps = {success:['success': result] }
			render json: { users:apps,status: :unprocessable_entity }
		end
	end

	def getRegistrosAdm
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
				
				userUbicacion = User.find(params[:usuario].split(",")[0].to_i)
			  	
		  	registro = Registry.where(user_id:userUbicacion.id).order('id DESC')
		 
		  	registro_arr =[]
		  	registro.each do |item|
		  		registro_arr.push({id:item.id, user: item.user.nombre, proyecto: item.proyecto.titulo ,update: item.updated_at.to_formatted_s(:short).to_s, titulo: item.titulo, descripcion: item.descripcion, resultado:item.resultado})
		  	end
		  	result = true
		  	render json: {registros:registro_arr,success: result}
		else
			result = false
			apps = {registros:['success': result] }
			render json: { registros:apps,status: :unprocessable_entity }
		end
	end

	def searchSold
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
		  	if Solicitud.where(id:params[:folio]).length>0
		  		solicitud = Solicitud.find(params[:folio])
		  		gps_arr=[{folio:solicitud.id, user: solicitud.user.nombre, proyecto: solicitud.proyecto.titulo,material: solicitud.materials.count, viaticos: solicitud.viaticos.count, vehiculo: solicitud.vehiculos.count, otro: solicitud.otro.count,fecha:solicitud.updated_at.to_formatted_s(:short).to_s}]
		  		result = true
		  		render json: {result:gps_arr,success: result}
		  	else
		  		result = false
				apps = {success: result}
				render json: { result:apps,status: :unprocessable_entity }
		  	end
		else
			result = false
			apps = {success:['success': result] }
			render json: { result:apps,status: :unprocessable_entity }
		end
	end

	def getSolicitud
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@solicitud = Solicitud.find(params[:folio])
			
			apps=[]
			
				materials=[]
				if(@solicitud.materials.count > 0)
					@solicitud.materials.each do |sitem|
						materials.push({id:sitem.id,cantidad:sitem.cantidad,material:sitem.material,descripcion:sitem.descripcion})
					end
				end

				viaticos=[]
				if(@solicitud.viaticos.count > 0)
					@solicitud.viaticos.each do |sitem|
						viaticos.push({id:sitem.id,cantidad:sitem.cantidad,detalles:sitem.descripcion})
					end
				end

				otro=[]
				if(@solicitud.otro.count > 0)
					@solicitud.otro.each do |sitem|
						otro.push({id:sitem.id,descripcion:sitem.descripcion})
					end
				end
				vehiculos=[]
				if(@solicitud.vehiculos.count > 0)
					@solicitud.vehiculos.each do |sitem|
						vehiculos.push({id:sitem.id,vehiculo:sitem.vehiculo,descripcion:sitem.descripcion})
					end
				end

				involucra=[]
				involucrados = SolicitudUser.where(solicitud: @solicitud)
				involucrados.each do |sitem|
					involucra.push({id:sitem.id,usuario:sitem.user.email+" "+EquipoUser(sitem.user)})
				end

				estado = "Cancelada"
				if(@solicitud.estado == "1")
					estado = "Abierta"
				elsif(@solicitud.estado == "2")
					estado = "Validada"
				elsif(@solicitud.estado =="3")
					estado = "Entregada"
				end
		  		apps.push({
		  			id:@solicitud.id,
		  			proyecto: @solicitud.proyecto.titulo, 
		  			fecha:@solicitud.created_at.to_formatted_s(:long).to_s,
		  			usuario: @solicitud.user.nombre,
		  			estado:estado,
		  			material: @solicitud.materials.count,
		  			vehiculo:@solicitud.vehiculos.count,
		  			otro:@solicitud.otro.count,
		  			viatico:@solicitud.viaticos.count,
		  			materials_arr:materials,
		  			vehiculo_arr:vehiculos,
		  			otro_arr:otro,
		  			viaticos_arr: viaticos,
		  			involucrado_arr:involucra
		  		})
			  
			result = [{result: true}]
			render json: {response:apps,result:result} 
		else
			result = false
			apps = {registro:[success: result,error:"no logeo"]}
			render json: {response:apps}
		end
	end
	def EquipoUser(users)
		@teams = Equipo.where(user:users)
		@deps  = EquipoUsuario.where(user:users)
		if @teams.size > 0
			tmp = ""
			@teams.each do |item|
				tmp = "Encargado de: "+item.nombre
			end
			return tmp.html_safe
		else
			tmp = ""
			if @deps.size > 0
				@deps.each do |item|
					tmp = "Pertenece a "+item.equipo.nombre 
				end
				return tmp.html_safe
			else
				return "Sin Equipo de Trabajo"
			end
		end
	end
	def getSolicitudesV
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
			if user.valid_password?(params[:password])
			  	if user.super_user or user.rol.nombre == "Gerente"
		  			@solicitudes = Solicitud.where(estado:"1").order('id DESC')
		  		elsif user.rol.nombre == "JefeDepartamento"
		  			users = User.where(users_id:user.id)
		  			@solicitudes = Solicitud.where(estado:"1",user_id:users).order('id DESC')
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
					result = false
					apps = {registro:[success: result,error:"size array"]}
					render json: {response:apps}
				end
			else
					result = false
					apps = {registro:[success: result,error:"size array"]}
					render json: {response:apps}
				end  	
		else
			result = false
			apps = {success:['success': result] }
			render json: { result:apps,status: :unprocessable_entity }
		end
	end

	def validateSold
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@solicitud = Solicitud.find(params[:folio])
			@solicitud.estado = "2"
			@solicitud.save 
			ma_arr = ActiveSupport::JSON.decode(params[:material])
			material = Material.find(ma_arr)
			if material.length > 0
				material.each do |item|
					item.autorizado = true
					item.save
				end
			end
			
			vi_arr = ActiveSupport::JSON.decode(params[:viatico])
			viaticos = Viatico.find(vi_arr)
			if viaticos.length > 0
				viaticos.each do |item|
					item.autorizada = true
					item.save
				end
			end
			notificacion(@solicitud)
			render json: {result:true} 
		else
			result = false
			apps = {registro:[success: result,error:"no logeo"]}
			render json: {response:apps}
		end
	end


	def notificacion(solicitud)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    usuariosSolicitud = SolicitudUser.where(solicitud: solicitud)
    users_arr = []
    	usuariosSolicitud.each do |item|
	    	users_arr.append(item.user_id)
	    	begin 
	    		Telegram.bot.send_message(chat_id: item.user.token_msj, text: "Solicitud con folio "+solicitud.id.to_s+", fue autorizada\n" +"<a href='http://gestor.tuperfil.com.mx/solicituds/"+solicitud.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
	    	rescue
   				print("None")
   			end
   			begin 	    		
	    		sendNotificacion("Autorizada","Solicitud con folio "+solicitud.id.to_s+", fue autorizada\n",item.user.auth_token)
	    	rescue
   				print("None")
   			end
   			begin
   				notif = Notificacion.new
	   			notif.user = item
	   			notif.texto = "Solicitud con folio"+solicitud.id.to_s+", Autorizada"
	   			notif.leido = false
	   			notif.tipo = "2"
	   			notif.save
   			rescue 
   				print("None")
   			end
    	end
	end




  def getStatusSolds
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
			if user.valid_password?(params[:password])
				users = User.find(params[:usuario].split(",")[0])
				proyecto = Proyecto.find(params['proyecto'].split(",")[0])
			  	@solicitudes = Solicitud.where(estado:"2",user:users,proyecto:proyecto).order('id DESC')
		  		if @solicitudes.length > 0
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
					result = false
					apps = {registro:[success: result,error:"No Existen Solicitudes para este usuario y proyecto"]}
					render json: {response:apps}
				end
			else
				result = false
				apps = {registro:[success: result,error:"Error Login"]}
					render json: {response:apps}
				end  	
		else
			result = false
			apps = {success:['success': result] }
			render json: { result:apps,status: :unprocessable_entity }
		end
	end
	def getSolicitudesF
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
			if user.valid_password?(params[:password])
			  	if user.super_user or user.rol.nombre == "Gerente"
		  			@solicitudes = Solicitud.where(estado:"2").order('id DESC')
		  		elsif user.rol.nombre == "JefeDepartamento"
		  			users = User.where(users_id:user.id)
		  			@solicitudes = Solicitud.where(estado:"2",user_id:users).order('id DESC')
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
					result = false
					apps = {registro:[success: result,error:"size array"]}
					render json: {response:apps}
				end
			else
					result = false
					apps = {registro:[success: result,error:"size array"]}
					render json: {response:apps}
				end  	
		else
			result = false
			apps = {success:['success': result] }
			render json: { result:apps,status: :unprocessable_entity }
		end
	end

	def finalizarSolicitud
		user = User.find_by_email(params[:email])
		if user.valid_password?(params[:password])
			@solicitud = Solicitud.find(params[:folio])
			@solicitud.estado = "3"
			@solicitud.save 
			notificacionEntrega(@solicitud)
			begin
				notif = Notificacion.new
				notif.user = user
				notif.texto = "Se finalizo Solicitud con folio"+@solicitud.id.to_s
				notif.leido = false
				notif.tipo = "3"
				notif.save
			rescue 
				print("None")
			end
			render json: {result:true} 
		else
			result = false
			apps = {registro:[success: result,error:"no logeo"]}
			render json: {response:apps}
		end
	end

    def notificacionEntrega(solicitud)
    Telegram.bots_config = {
        default: "466063182:AAF8tbj997GR4P8CRNHazeYOQkNHCcr1pBs",
      }
    begin
   		Telegram.bot.send_message(chat_id: solicitud.user.token_msj, text: "Solicitud con folio "+solicitud.id.to_s+", fue entregada\n" +"<a href='http://gestor.tuperfil.com.mx/solicituds/"+solicitud.id.to_s+"'>Revisar Solicitud</a>",parse_mode: "HTML")
   	rescue
   		print("None");
   	end
   	begin
   		sendNotificacion("Entregada","Solicitud con folio "+solicitud.id.to_s+", fue entregada",solicitud.user.auth_token)
   	rescue
   		print("None")
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
