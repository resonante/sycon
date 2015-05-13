json.array!(@valuations) do |valuation|
  json.extract! valuation, :id, :title, :purchase_order, :purchase_order_id
  json.value number_to_currency(Valuation.find_by_sql("select sum(vi.value * pi.price) as total from valuation_items vi
                                          inner join purchase_order_items pi on pi.id = vi.purchase_order_item_id
                                          where vi.valuation_id = #{valuation.id.to_s}").sum.total, unit: '', separator: ",", delimiter: ".")
  json.quantity number_to_currency(valuation.valuation_items.sum(:value), unit: '', separator: ",", delimiter: ".")
  json.url valuation_url(valuation, format: :json)
end
