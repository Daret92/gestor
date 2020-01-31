class AdmController < ApplicationController
	before_action :set_rol, only: [:edit_rol, :update_rol, :delete_rol]
  before_action :authenticate_user!
  #roles
  def rol
  	@rol = Rol.all()
  end
  
  def new_rol
    Rails.application.eager_load!
  	@rol = Rol.new
  	@rol.permissions.build
    @permisos_all = ApplicationRecord.descendants.collect { |type| type.name }
    @permisos = []
    @permisos_all.each do |item|
      if !["Permission", "EquipoUsuario"].include?(item)
        @permisos.append(item)
      end      
    end
  end
  
  def edit_rol	
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
 #Termina roles
 #usuarios
  def user
    @users = User.where(super_user:false).order(activo: :DESC)
  end
  
  def user_new
    @user = User.new
    @rols = Rol.all()
  end
  def user_edit
    @user = User.find(params[:id])
    @rols = Rol.all()
  end

  def user_create
    @user = User.new(user_params)
    respond_to do |format|
       if @user.save
        format.html { redirect_to usuarios_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location:usuarios_path }
      else
        format.html { render :user_new }
      end
    end
  end

  def user_update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to usuarios_path, notice: 'Article was successfully updated.' }
      else
        format.html { render :user_edit }
      end
    end
  end

  def user_delete
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to usuarios_path, notice: 'Usuario a sido borrado' }
      format.json { head :no_content }
    end
  end

  def editar_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(password)
        format.html { redirect_to user_edit_path(@user.id), notice: 'Article was successfully updated.' }
      else
        raise
        format.html { render :user_edit }
      end
    end
  end
#Termina usuarios
#inicia Grupo de Trabajo
  def equipo
    @equipo = Equipo.all()
  end
  def equipo_nuevo
    @equipo = Equipo.new
  end
  def equipo_edit
    @equipo = Equipo.find(params[:id])
  end
  def equipo_create
    @equipo = Equipo.new(grup_params)
    respond_to do |format|
      if @equipo.save
        format.html { redirect_to equipo_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location:equipo_path }
      else
        format.html { render :new_rol }
      end
    end
  end
  def equipo_update
    @equipo = Equipo.find(params[:id])
    respond_to do |format|
      if @equipo.update(grup_params)
        format.html { redirect_to equipo_path, notice: 'Article was successfully updated.' }
      else
        format.html { render :user_edit }
      end
    end
  end
  def equipo_delete
    @equipo = Equipo.find(params[:id])
    @equipo.destroy
    respond_to do |format|
      format.html { redirect_to equipo_path, notice: 'Equipo de Trabajo a sido borrado' }
      format.json { head :no_content }
    end
  end
#Termina Grupo de trabajo
  private
  def set_rol
    Rails.application.eager_load!
    @rol = Rol.find(params[:id])
    @permisos_all = ApplicationRecord.descendants.collect { |type| type.name }
    @permisos_existe = Permission.where(rol_id:@rol.id).collect{ |tips| tips.title}
    @permisos = []
    @permisos_all.each do |item|
      if !["Permission", "EquipoUsuario"].include?(item)
        @permisos.append(item)
      end      
    end
  end
  def grup_params
    params.require(:equipo).permit(:nombre,:activo,:user_id, equipo_usuario_attributes: EquipoUsuario.attribute_names.map(&:to_sym).push(:_destroy))
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def password
    params.require(:user).permit(:password,:password_confirmation,:id)
  end
  def rol_params
    #params.require(:rol).permit(:nombre, :descripcion, :activo, permission_attributes:[:id,:nombre,:activo])
    params.require(:rol).permit(:nombre, :descripcion, :activo, permissions_attributes: Permission.attribute_names.map(&:to_sym).push(:_destroy))
  end

  def user_params
    params.require(:user).permit(:nombre,:token_msj,:apellido,:email,:encrypted_password,:password,:password_confirmation,:rol_id,:users_id,:alias,:activo,:avatar)
  end
end
