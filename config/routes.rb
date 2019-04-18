Rails.application.routes.draw do
  
  #apis
  get 'api_app/login'
  get 'api_app/get_users'
  get 'api_app/save_sold'
  get 'api_app/save_registre'
  get 'api_app/get_allR'
  get 'api_app/gps_save'
  get 'api_app/save_bitacora'
  get 'api_app/get_bitacora'
  get 'api_app/getSolicitudsTeam'

  #scaffolds
  resources :cvehiculos
  resources :registries
  resources :solicituds
  resources :proyectos
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
  
  #Autorizacion cancelacion actualizacion de solicitudes via ajax
  get '/update_materials', to: 'solicituds#update_materials', :defaults => {:format => 'json'}
  get '/update_viaticos', to: 'solicituds#update_viaticos', :defaults => {:format => 'json'}
  get '/validate_materials', to: 'solicituds#validate_materials', :defaults => {:format => 'json'}
  get '/authSolicitud', to: 'solicituds#authSolicitud'
  get '/finSolicitud', to: 'solicituds#finSolicitud'
  get '/cancSolicitud', to: 'solicituds#cancSolicitud'

  #Commonts
  get '/gps', to:'commont#gps'

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
