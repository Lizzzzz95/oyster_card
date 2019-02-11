MAX_BALANCE = 90

class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(value)
    if (@balance + value) > MAX_BALANCE
      raise 'Oyster balance cannot exceed £90'
    else
      @balance += value
    end
  end

end
