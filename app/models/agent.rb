class Agent < ActiveRecord::Base
	has_many :work_assignments, dependent: :destroy
	has_many :works, :through => :work_assignments
	belongs_to :customer
end
