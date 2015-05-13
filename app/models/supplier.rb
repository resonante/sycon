class Supplier < ActiveRecord::Base
	belongs_to :work

	validates :name, :agent, :rif, :address, presence: true
	validates :work, presence: true
end
