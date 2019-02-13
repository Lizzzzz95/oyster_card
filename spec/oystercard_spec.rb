require 'oystercard'
require 'station'

describe Oystercard do

  it 'checks oyster card balance is 0' do
    expect(subject.balance).to eq 0
  end

  it 'is not in a journey' do
    expect(subject.in_journey?).to eq false
  end


  describe '#top_up' do

    it 'raises an error if balance exceeds £90' do
      expect { subject.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "Oyster balance cannot exceed £#{Oystercard::MAX_BALANCE}"
    end

    it 'tops up card balance' do
      expect{ subject.top_up(Oystercard::MIN_FARE) }.to change{ subject.balance }.by(Oystercard::MIN_FARE)
    end

  end


  describe '#touch_in' do

    it 'will not touch in if below minimum balance' do
      station = Station.new('name', 1)
      expect{ subject.touch_in(station) }.to raise_error "Oyster balance too low to tap in"
    end

    it 'remembers entry station after touch in' do
      station = Station.new('name', 1)
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
      expect(subject.in_journey?).to eq true
    end

  end


  describe '#touch_out' do

    it 'checks if user has touched out' do
      station = Station.new('name', 1)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end

    it 'dedcuts min fare when user touches out' do
      station = Station.new('name', 1)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by (- Oystercard::MIN_FARE)
    end

  end


  describe '#save_journey' do

    it 'saves journey into journey list' do
      entry_station = Station.new('name', 1)
      exit_station = Station.new('name', 1)
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to eq [{
        :entry_station => entry_station,
        :exit_station => exit_station
      }]
    end

  end

  it 'resets entry and exit station to nil' do
    station = Station.new('name', 1)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
    expect(subject.exit_station).to eq nil
  end

end
