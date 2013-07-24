json.array!(@plates) do |plate|
  json.extract! plate, :state, :number, :phone
  json.url plate_url(plate, format: :json)
end
