coaches = Coach.create([{name: 'Ana'}, {name: 'Carlos'}])
clients = Client.create([{name: 'Camila', coach: coaches[0]}, {name: 'Abby', coach: coaches[0]}])

today = Time.now
i = 1

while i < 30
	hour = 10
	
	while hour < 15
		TimeSlot.create({coach_id: coaches.first.id, hour: hour, date: today + i.day})
		TimeSlot.create({coach_id: coaches.last.id, hour: hour, date: today + i.day})
		TimeSlot.create({coach_id: coaches.last.id, hour: hour, date: today + i.day})
		hour += 1
	end  

	i += 1
end

clients.first.time_slots << clients.first.coach.time_slots[10]
clients.last.time_slots << clients.last.coach.time_slots[15]