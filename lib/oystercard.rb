require_relative 'station'

MAX_BALANCE = 90
MIN_FARE = 1

class Oystercard

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
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

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end

  private :deduct

end
