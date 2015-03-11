json.array!(@works) do |work|
  json.extract! work, :id, :name, :date, :customer
  json.date work.date.strftime('%d-%m-%Y')
  json.url work_url(work, format: :json)
end
