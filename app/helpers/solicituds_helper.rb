module SolicitudsHelper
	def getTeam(users)
		@teams = Equipo.where(user:users)
		@deps  = EquipoUsuario.where(user:users)
		if @teams.size > 0
			tmp = ""
			@teams.each do |item|
				tmp = tmp + "- <i class='fas fa-chess-king'></i> "+item.nombre 
			end
			return tmp.html_safe
		else
			tmp = ""
			@deps.each do |item|
				tmp = tmp + "- <i class='fas fa-chess-pawn'></i> "+item.equipo.nombre 
			end
			return tmp.html_safe
		end
	end
	def EquipoUser(users)
		@teams = Equipo.where(user:users)
		@deps  = EquipoUsuario.where(user:users)
		if @teams.size > 0
			tmp = ""
			@teams.each do |item|
				tmp = users.nombre+" - Encargado de: "+item.nombre
			end
			return tmp.html_safe
		else
			tmp = ""
			if @deps.size > 0
				@deps.each do |item|
					tmp = users.nombre+" - Pertenece a: "+ item.equipo.nombre 
				end
				return tmp.html_safe
			else
				return users.nombre+" - Sin Equipo de Trabajo"
			end
		end
	end
end
