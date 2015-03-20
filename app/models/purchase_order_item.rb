class PurchaseOrderItem < ActiveRecord::Base
	attr_accessor :total
	belongs_to :purchase_order
end
