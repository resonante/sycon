class PaymentOrder < ActiveRecord::Base
	has_many :purchase_order_items
end
