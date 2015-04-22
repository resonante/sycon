class PurchaseOrderItem < ActiveRecord::Base
	attr_accessor :total
	belongs_to :purchase_order
	has_many :valuation_items
	default_scope { order('item ASC') }

	def acumulated_value
		valuation_items.where('valuation_id != '+@valuation.id.to_s).sum(:value)
	end	
end
