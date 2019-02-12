require 'oystercard'

describe Oystercard do

  let(:station){ double :station }

  it 'checks oyster card balance is 0' do
    expect(subject.balance).to eq 0
  end

  it 'will not touch in if below minimum balance' do
    expect{ subject.touch_in(station) }.to raise_error "Oyster balance too low to tap in"
  end


  describe '#top_up' do

    it "raises an error if balance exceeds £90" do
      expect { subject.top_up(Oystercard::MAX_BALANCE + 1) }.to raise_error "Oyster balance cannot exceed £#{Oystercard::MAX_BALANCE}"
    end

    it 'tops up card balance' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

  end

  it 'is not in a journey' do
    expect(subject.in_journey?).to eq false
  end


  describe '#touch_in' do

    it 'remembers entry station after touch in' do
      expect{subject.top_up(Oystercard::MIN_FARE)}.to change{subject.balance}.by Oystercard::MIN_FARE
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end


  describe '#touch_out' do

    it 'checks if user has touched out' do
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

    it 'dedcuts min fare when user touches out' do
      expect{subject.touch_out}.to change{subject.balance}.by (- Oystercard::MIN_FARE)
    end

  end

end
