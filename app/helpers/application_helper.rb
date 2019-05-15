module ApplicationHelper
	def mobile_device
	  agent = request.user_agent
	  return "tablet" if agent =~ /(tablet|ipad)|(android(?!.*mobile))/i
	  return "mobile" if agent =~ /Mobile/
	  return "desktop"
	end	
	def link_to_add_row(name,f,association,**args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association,new_object,child_index: id) do |builder|
			render(association.to_s.singularize, f: builder)
		end
		link_to(name, "#", class: "add_fields "+ args[:class], data:{id:id, fields:fields.gsub("\n","")})
	end

	def link_to_add_user(name,f,association,**args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association,new_object,child_index: id) do |builder|
			render(association.to_s.singularize, f: builder)
		end
		link_to(name, "#", class: "add_users "+ args[:class], data:{id:id, field:fields.gsub("\n","")})
	end

	def link_to_add_vehiculo(name,f,association,**args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association,new_object,child_index: id) do |builder|
			render(association.to_s.singularize, f: builder)
		end
		link_to(name, "#", class: "add_vehiculo "+ args[:class], data:{id:id, fieldv:fields.gsub("\n","")})
	end

	def link_to_add_viatico(name,f,association,**args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association,new_object,child_index: id) do |builder|
			render(association.to_s.singularize, f: builder)
		end
		link_to(name, "#", class: "add_viatico "+ args[:class], data:{id:id, fieldvi:fields.gsub("\n","")})
	end

	def link_to_add_otro(name,f,association,**args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.simple_fields_for(association,new_object,child_index: id) do |builder|
			render(association.to_s.singularize, f: builder)
		end
		link_to(name, "#", class: "add_otro "+ args[:class], data:{id:id, fieldo:fields.gsub("\n","")})
	end

	def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
