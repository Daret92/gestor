# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Rol.create(nombre:"Gerente",descripcion:"Todos los permisos", activo:true)
Rol.create(nombre:"JefeDepartamento",descripcion:"Permisos de JefeDepartamento", activo:true)
Rol.create(nombre:"Empleado",descripcion:"Permisos Limitados", activo:true)
User.create(nombre:"SuperUser", apellido: "SuperUser", alias:"Adm",super_user: true, activo:true,email:'admin@tuperfil.com',password: 'Dareth1992', token_msj:340614248)