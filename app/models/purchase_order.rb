class PurchaseOrder < ActiveRecord::Base
	belongs_to :customer
	belongs_to :work
	belongs_to :supplier
	has_many :purchase_order_items, :dependent => :destroy, :autosave => true
	has_many :childs, :class_name => "PurchaseOrder", :foreign_key => :parent_id
	belongs_to :parent, :class_name => "PurchaseOrder"
	#has_paper_trail
	accepts_nested_attributes_for :purchase_order_items, allow_destroy: true
end
