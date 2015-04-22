json.array!(@valuation_items) do |valuation_item|
  json.extract! valuation_item, :id
  json.url valuation_item_url(valuation_item, format: :json)
end
