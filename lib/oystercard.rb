MAX_BALANCE = 90
MIN_FARE = 1

class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
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
    false
  end

  def touch_in
    raise 'Oyster balance too low to tap in' if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

  private :deduct

end
