class Valuation < ActiveRecord::Base
	belongs_to :purchase_order
	has_many :valuation_items, :dependent => :destroy, :autosave => true
	accepts_nested_attributes_for :purchase_order
	accepts_nested_attributes_for :valuation_items, allow_destroy: true
end
