class Client < ActiveRecord::Base
	belongs_to :coach
	has_many :time_slots
end
