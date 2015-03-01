json.array!(@purchase_order_items) do |purchase_order_item|
  json.extract! purchase_order_item, :id
  json.url purchase_order_item_url(purchase_order_item, format: :json)
end
