class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :permissions
	def permissions
		if current_user
			if current_user.super_user == true
	  			@permissions_user = 'super_user'
		  	else
				@permissions_user = current_user.rol.permissions.where(active:true).collect {|tit| tit.title} 
			end
		end
	end
end
