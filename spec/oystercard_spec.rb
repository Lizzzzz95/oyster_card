require 'oystercard'

describe Oystercard do

  it 'checks oyster card balance is 0' do
    expect(subject.balance).to eq 0
  end


  describe '#top_up' do

    it 'raises an error if balance exceeds £90' do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect { subject.top_up 1 }.to raise_error "Oyster balance cannot exceed £#{max_balance}"
    end

    it 'tops up card balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

  end

end
