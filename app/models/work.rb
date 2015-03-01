class Work < ActiveRecord::Base
	has_many :suppliers
	belongs_to :customer
end
