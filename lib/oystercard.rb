require_relative 'station'
require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance, :journeys

  def initialize
    @balance = 0
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

  def touch_in(station)
    raise 'Oyster balance too low to tap in' if @balance < Journey::MIN_FARE
    if @journey != nil
      deduct(@journey.fare)
      save_journey
    end
    @journey = Journey.new
    @journey.start(station)
  end

  def touch_out(station)
    if @journey == nil
      @journey = Journey.new
    end
    @journey.end(station)
    deduct(@journey.fare)
    save_journey
    reset_stations
  end

  def save_journey
    @journeys << {
      :entry_station => @journey.entry_station,
      :exit_station => @journey.exit_station
    }
  end

  def reset_stations
    @journey.entry_station, @journey.exit_station = nil, nil
  end

  private :deduct, :save_journey, :reset_stations

end
