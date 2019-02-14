require 'oystercard'
require 'station'
require 'journey'

describe Oystercard do

  it 'checks oyster card balance is 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'raises an error if balance exceeds £90' do
      expect { subject.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "Oyster balance cannot exceed £#{Oystercard::MAX_BALANCE}"
    end

    it 'tops up card balance' do
      expect{ subject.top_up(Journey::MIN_FARE) }.to change{ subject.balance }.by(Journey::MIN_FARE)
    end

  end


  describe '#touch_in' do

    it 'will not touch in if below minimum balance' do
      station = Station.new('name', 1)
      expect{ subject.touch_in(station) }.to raise_error "Oyster balance too low to tap in"
    end

  end

  describe '#touch_out' do

    it 'deducts maximum charge if journey was not started' do
      subject.top_up(Journey::MAX_FARE)
      station = Station.new('name', 1)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Journey::MAX_FARE)
    end

    it 'deducts minimum charge if touch in was done' do
      station = Station.new('name', 1)
      subject.top_up(Journey::MIN_FARE)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by (-Journey::MIN_FARE)
      expect(subject.journeys).to eq [{
        :entry_station => station,
        :exit_station => station
      }]
    end

  end

end
