class Journey

  MIN_FARE = 1
  MAX_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def complete
    @entry_station != nil && @exit_station != nil
  end

  def fare
    if complete
      MIN_FARE
    else
      MAX_FARE
    end
  end

end
