Rails.application.routes.draw do
  #Roles
  get 'roles',to:"adm#rol", as: "roles"
  get 'crear_rol',to:'adm#new_rol', as: "crear_rol"
  post 'adm/create_rol'
  delete 'delete_rol/:id', to:'adm#delete_rol', as:"delete_rol"
  get 'edit_rol/:id',to:'adm#edit_rol', as: "edit_rol"
  patch 'update_rol',to: 'adm#update_rol'
  #usuarios
  get 'usuarios', to:'adm#user', as: "usuarios"
  get 'nuevoUsuario', to: 'adm#user_new', as: 'nuevoUsuario'
  post 'adm/user_create'
  get 'editar_usuario/:id',to:'adm#user_edit', as: "user_edit"
  patch 'user_update', to: 'adm#user_update'
  delete 'user_delete/:id', to:'adm#user_delete', as:"user_delete"
  get 'edit_password/:id', to: 'adm#editar_password', as: "edit_password"
  patch 'update_password', to: 'adm#update_password'
  # grupos
  get 'equipo', to:'adm#equipo', as: "equipo"
  get 'equipo_nuevo', to: 'adm#equipo_nuevo', as: "equipo_nuevo"
  post 'equipo_create', to: 'adm#equipo_create'
  get 'equipo_edit/:id',to:'adm#equipo_edit', as: "equipo_edit"
  delete 'equipo_delete/:id', to: 'adm#equipo_delete', as: "equipo_delete"
  patch 'equipo_update', to: 'adm#equipo_update'
  
  authenticated :user do
    root 'dasboard#index'
  end
  unauthenticated :user do
  	devise_scope :user do
  		root 'dasboard#dasboard', as: :unregistered_root
  	end
  end
  devise_for :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
