json.array!(@payment_orders) do |payment_order|
  json.extract! payment_order, :id
  json.url payment_order_url(payment_order, format: :json)
end
