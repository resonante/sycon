class ValuationItem < ActiveRecord::Base
	attr_accessor :total
	belongs_to :valuation
	belongs_to :purchase_order_item
end
