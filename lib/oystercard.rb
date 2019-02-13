require_relative 'station'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(amount)
    if (@balance + amount) > MAX_BALANCE
      raise "Oyster balance cannot exceed £#{MAX_BALANCE}"
    else
      @balance += amount
    end
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise 'Oyster balance too low to tap in' if @balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    save_journey
    reset_stations
  end

  def save_journey
    @journeys << {
      :entry_station => @entry_station,
      :exit_station => @exit_station
    }
  end

  def reset_stations
    @entry_station, @exit_station = nil, nil
  end

  private :deduct, :save_journey, :reset_stations

end
