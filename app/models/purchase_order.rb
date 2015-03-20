class PurchaseOrder < ActiveRecord::Base
	belongs_to :customer
	belongs_to :work
	belongs_to :supplier
	has_many :purchase_order_items, :dependent => :destroy, :autosave => true

	accepts_nested_attributes_for :purchase_order_items, allow_destroy: true
end
