json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :email, :description
  json.url customer_url(customer, format: :json)
end
