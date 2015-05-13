class Customer < ActiveRecord::Base
	belongs_to :work
	has_many :agents
	has_many :valuations

	validates :name, presence: true
	validates :address, presence: true
end
