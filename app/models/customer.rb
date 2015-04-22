class Customer < ActiveRecord::Base
	belongs_to :work
	has_many :agents
	has_many :valuations
end
