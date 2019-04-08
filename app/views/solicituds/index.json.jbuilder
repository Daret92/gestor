json.set! :data do
  json.array! @solicituds do |solicitud|
    json.partial! 'solicituds/solicitud', solicitud: solicitud
    json.url  "
              #{link_to 'Show', solicitud }
              #{link_to 'Edit', edit_solicitud_path(solicitud)}
              #{link_to 'Destroy', solicitud, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end