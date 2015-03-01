class PurchaseOrderItem < ActiveRecord::Base
	belongs_to :purchase_order
end
