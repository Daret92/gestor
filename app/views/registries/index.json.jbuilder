json.set! :data do
  json.array! @registries do |registry|
    json.partial! 'registries/registry', registry: registry
    json.url  "
              #{link_to 'Show', registry }
              #{link_to 'Edit', edit_registry_path(registry)}
              #{link_to 'Destroy', registry, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end