class ApiAdmController < ApplicationController
	def get_users_proyecto
		if !params[:email].empty? and !params[:password].empty?
			user = User.find_by_email(params[:email])
			users = User.where(users_id:user.id)
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
				
				userUbicacion = User.find(params[:usuario][0].to_i)
	
				userProyecto = Proyecto.find(params[:proyecto][0].to_i)

		  	
		  	gps = GpsSave.where(user_id:userUbicacion.id,proyecto_id:userProyecto.id)
		 
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
				
				userUbicacion = User.find(params[:usuario][0].to_i)
			  	
		  	registro = Registry.where(user_id:userUbicacion.id)
		 
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
end
