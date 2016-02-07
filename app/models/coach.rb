class Coach < ActiveRecord::Base
	has_many :clients
	has_many :time_slots, dependent: :destroy
end
