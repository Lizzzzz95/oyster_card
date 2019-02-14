require 'journey'
require 'station'

describe Journey do

  it 'starts a journey' do
    station = Station.new('name', 1)
    expect(subject.start(station)).to eq station
  end

  it 'ends a journey' do
    station = Station.new('name', 1)
    expect(subject.end(station)).to eq station
  end

  it 'returns true if journey is complete' do
    station = Station.new('name', 1)
    subject.start(station)
    subject.end(station)
    expect(subject.complete).to be true
  end

  it 'returns min fare if journey is complete' do
    station = Station.new('name', 1)
    subject.start(station)
    subject.end(station)
    expect(subject.fare).to eq Journey::MIN_FARE
  end

  it 'returns max fare if journey is not complete' do
    station = Station.new('name', 1)
    subject.start(station)
    expect(subject.fare).to eq Journey::MAX_FARE
  end

end
