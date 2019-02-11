MAX_BALANCE = 90

class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
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

end
