Rails.application.routes.draw do
  get 'usuarios', to:'adm#user', as: "usuarios"

  get 'roles',to:"adm#rol", as: "roles"
  get 'crear_rol',to:'adm#new_rol', as: "crear_rol"
  post 'adm/create_rol'
  delete 'delete_rol/:id', to:'adm#delete_rol', as:"delete_rol"
  get 'edit_rol/:id',to:'adm#edit_rol', as: "edit_rol"
  patch 'update_rol',to: 'adm#update_rol'

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
