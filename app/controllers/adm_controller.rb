class AdmController < ApplicationController
	before_action :set_rol, only: [:edit_rol, :update_rol, :delete_rol]

  def rol
  	@rol = Rol.all()
  end
  
  def new_rol
  	@rol = Rol.new
  	@rol.permissions.build
  end
  
  def edit_rol
  	@rol.permissions.build
  end
	def update_rol
	  respond_to do |format|
      if @rol.update(rol_params)
        format.html { redirect_to roles_path, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit_rol }
      end
    end
	end

  def create_rol
  	raise 
  	@rol = Rol.new(rol_params)
    respond_to do |format|
      if @rol.save
        format.html { redirect_to roles_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location:roles_path }
      else
        format.html { render :new_rol }
      end
    end
  end

  def delete_rol
    @rol.destroy
    respond_to do |format|
      format.html { redirect_to roles_path, notice: 'Roles was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user
  end
  
  private
  def set_rol
      @rol = Rol.find(params[:id])
    end
  # Never trust parameters from the scary internet, only allow the white list through.
  def rol_params
    #params.require(:rol).permit(:nombre, :descripcion, :activo, permission_attributes:[:id,:nombre,:activo])
    params.require(:rol).permit(:nombre, :descripcion, :activo, permissions_attributes: Permission.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
