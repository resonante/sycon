json.array!(@valuations) do |valuation|
  json.extract! valuation, :id
  json.url valuation_url(valuation, format: :json)
end
