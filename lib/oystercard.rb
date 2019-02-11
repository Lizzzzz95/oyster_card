MAX_BALANCE = 90

class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
    @status_of_card = false
  end

  def top_up(amount)
    if (@balance + amount) > MAX_BALANCE
      raise 'Oyster balance cannot exceed £90'
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
    @status_of_card = true
  end

  def touch_out
    @status_of_card = false
  end

end
