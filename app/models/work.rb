class Work < ActiveRecord::Base
	has_many :suppliers
	belongs_to :customer

	validates :customer, presence: true
	validates :name, :address, presence: true	
end
