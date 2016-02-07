class TimeSlotsController < ApplicationController
  before_action :current_user

  def get_slots
    coach = get_coach
    month = get_month
    first_day_of_month = Date.new(2016, month, 1)
    last_day_of_month = first_day_of_month.end_of_month
    time_slots = get_one_month_of_timeslots month, coach, first_day_of_month, last_day_of_month
    
    @time_slots = get_time_slots_order_by_day time_slots, first_day_of_month, last_day_of_month

    respond_to do |format|
      format.json { render json: @time_slots.to_json }
    end
  end

  def reserve_delete_spot
    @time_slot = get_time_slot

    if (@time_slot.client_id == nil && client_has_no_appt_in_month) 
      @time_slot.client_id = cookies[:user]
    else 
      @time_slot.client_id = nil
    end
    
    @time_slot.save

    respond_to do |format|
      format.json { render json: @time_slot.to_json }
    end
  end

  private
  def current_user
    if cookies[:user]
      @client = Client.find cookies[:user]
    end
  end

  def get_coach
    Coach.find(params[:coach_id])
  end

  def get_month
    params[:month].to_i
  end

  def get_time_slot
    TimeSlot.find params[:time_slot_id]
  end

  def get_one_month_of_timeslots(month, coach, first_day_of_month, last_day_of_month)
    coach.time_slots.where("date > ? AND date < ? AND client_id IS NULL OR client_id = ?", 
                            first_day_of_month, last_day_of_month, @client.id).reorder('hour')  
  end

  def get_time_slots_order_by_day(time_slots, first_day_of_month, last_day_of_month)
    time_slots_by_day = {}

    (first_day_of_month..last_day_of_month).each do |day|
      formatted_day = day.strftime('%a, %b %d')
      time_slots_by_day["#{formatted_day}"] = []

      time_slots.each do |time_slot|
        if( time_slot.date.strftime('%Y-%m-%d').to_s == day.to_s )
          time_slots_by_day["#{formatted_day}"] << time_slot
        end
      end
    end

    time_slots_by_day.reject{ |k, v| v.empty? }
  end

  def client_has_no_appt_in_month
    month = @time_slot.date.strftime('%m').to_i
    first_day_of_month = Date.new(2016, month, 1)
    last_day_of_month = first_day_of_month.end_of_month

    unless @client.time_slots.empty?
      @client.time_slots.each do |time_slot|
        if time_slot.date >= first_day_of_month && time_slot.date <= last_day_of_month
          return false
        end
      end
    end

    return true
  end
end