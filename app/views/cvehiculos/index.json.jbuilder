json.set! :data do
  json.array! @cvehiculos do |cvehiculo|
    json.partial! 'cvehiculos/cvehiculo', cvehiculo: cvehiculo
    json.url  "
              #{link_to 'Show', cvehiculo }
              #{link_to 'Edit', edit_cvehiculo_path(cvehiculo)}
              #{link_to 'Destroy', cvehiculo, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end