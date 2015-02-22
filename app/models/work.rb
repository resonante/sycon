class Work < ActiveRecord::Base
	has_many :suppliers
	has_one :costumers
end
