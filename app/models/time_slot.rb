class TimeSlot < ActiveRecord::Base
	validates_uniqueness_of :coach_id, scope: [:hour, :date]

	belongs_to :coach
	belongs_to :client
end