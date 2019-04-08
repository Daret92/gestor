# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_30_183214) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "equipo_usuarios", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "activo"
    t.integer "equipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipo_id"], name: "index_equipo_usuarios_on_equipo_id"
    t.index ["user_id"], name: "index_equipo_usuarios_on_user_id"
  end

  create_table "equipos", force: :cascade do |t|
    t.integer "equipo_usuario_id"
    t.integer "user_id"
    t.string "nombre"
    t.boolean "activo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipo_usuario_id"], name: "index_equipos_on_equipo_usuario_id"
    t.index ["user_id"], name: "index_equipos_on_user_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "cantidad"
    t.string "material"
    t.string "descripcion"
    t.boolean "autorizado", default: true
    t.boolean "entregado"
    t.integer "solicitud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solicitud_id"], name: "index_materials_on_solicitud_id"
  end

  create_table "otros", force: :cascade do |t|
    t.integer "solicitud_id"
    t.string "descripcion"
    t.boolean "finalizada"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solicitud_id"], name: "index_otros_on_solicitud_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "title"
    t.boolean "active"
    t.integer "rol_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rol_id"], name: "index_permissions_on_rol_id"
  end

  create_table "proyectos", force: :cascade do |t|
    t.string "titulo"
    t.string "estado"
    t.date "inicio"
    t.date "fin"
    t.string "descripcion"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_proyectos_on_user_id"
  end

  create_table "registries", force: :cascade do |t|
    t.integer "proyecto_id"
    t.integer "user_id"
    t.string "titulo"
    t.string "descripcion"
    t.string "resultado"
    t.boolean "finalizado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proyecto_id"], name: "index_registries_on_proyecto_id"
    t.index ["user_id"], name: "index_registries_on_user_id"
  end

  create_table "rols", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.integer "permission_id"
    t.boolean "activo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_rols_on_permission_id"
  end

  create_table "solicitud_users", force: :cascade do |t|
    t.integer "solicitud_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solicitud_id"], name: "index_solicitud_users_on_solicitud_id"
    t.index ["user_id"], name: "index_solicitud_users_on_user_id"
  end

  create_table "solicituds", force: :cascade do |t|
    t.integer "proyecto_id"
    t.string "estado"
    t.string "observaciones"
    t.integer "user_id"
    t.integer "material_id"
    t.integer "viatico_id"
    t.integer "vehiculo_id"
    t.integer "otro_id"
    t.integer "solicitud_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["material_id"], name: "index_solicituds_on_material_id"
    t.index ["otro_id"], name: "index_solicituds_on_otro_id"
    t.index ["proyecto_id"], name: "index_solicituds_on_proyecto_id"
    t.index ["solicitud_user_id"], name: "index_solicituds_on_solicitud_user_id"
    t.index ["user_id"], name: "index_solicituds_on_user_id"
    t.index ["vehiculo_id"], name: "index_solicituds_on_vehiculo_id"
    t.index ["viatico_id"], name: "index_solicituds_on_viatico_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "rol_id"
    t.integer "users_id"
    t.boolean "super_user", default: false
    t.string "alias"
    t.string "nombre"
    t.string "apellido"
    t.string "auth_token"
    t.boolean "activo"
    t.string "token_msj"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["rol_id"], name: "index_users_on_rol_id"
    t.index ["users_id"], name: "index_users_on_users_id"
  end

  create_table "vehiculos", force: :cascade do |t|
    t.integer "solicitud_id"
    t.string "vehiculo"
    t.string "descripcion"
    t.boolean "devuelto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solicitud_id"], name: "index_vehiculos_on_solicitud_id"
  end

  create_table "viaticos", force: :cascade do |t|
    t.string "cantidad"
    t.string "descripcion"
    t.boolean "autorizada"
    t.boolean "entrega"
    t.integer "solicitud_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solicitud_id"], name: "index_viaticos_on_solicitud_id"
  end

end
