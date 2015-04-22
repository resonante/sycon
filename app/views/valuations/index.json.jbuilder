json.array!(@valuations) do |valuation|
  json.extract! valuation, :id, :title, :purchase_order
  json.value number_to_currency(valuation.valuation_items.sum(:value), unit: '', separator: ",", delimiter: ".")
  json.url valuation_url(valuation, format: :json)
end
