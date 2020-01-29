json.set! :data do
  json.array! @home_works do |home_work|
    json.partial! 'home_works/home_work', home_work: home_work
    json.url  "
              #{link_to 'Show', home_work }
              #{link_to 'Edit', edit_home_work_path(home_work)}
              #{link_to 'Destroy', home_work, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end