json.set! :data do
  json.array! @proyectos do |proyecto|
    json.partial! 'proyectos/proyecto', proyecto: proyecto
    json.url  "
              #{link_to 'Show', proyecto }
              #{link_to 'Edit', edit_proyecto_path(proyecto)}
              #{link_to 'Destroy', proyecto, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end