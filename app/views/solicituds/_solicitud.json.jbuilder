json.extract! solicitud, :id, :proyecto_id, :estado, :observaciones, :user_id, :material_id, :viatico_id, :vehiculo_id, :otro_id, :created_at, :updated_at
json.url solicitud_url(solicitud, format: :json)
