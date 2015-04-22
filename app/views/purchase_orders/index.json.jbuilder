json.array!(@purchase_orders) do |purchase_order|
  json.extract! purchase_order, :id, :reference, :customer, :work
  json.value number_to_currency(purchase_order.total_value, unit: '', separator: ",", delimiter: ".")
  json.url purchase_order_url(purchase_order, format: :json)
end
