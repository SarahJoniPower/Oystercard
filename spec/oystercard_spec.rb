require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:balance) }

  it 'has a starting balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add amount to balance' do
      subject.top_up(5)
      expect(subject.balance).to eq 5
    end

    it 'should raise an error if balance is already at maximum limit' do
      subject.top_up(Oystercard::MAXIMUM_LIMIT)
      expect { subject.top_up(1) }.to raise_error "balance exceeds £#{Oystercard::MAXIMUM_LIMIT}"
    end
  end

  describe "#touch_in" do
    let(:station) {"Picadilly"}
    it { is_expected.to respond_to(:touch_in) }

    it 'should change journey_status to true if minimum amount is met' do
      subject.top_up(10)
      expect { subject.touch_in(station) }.to change {subject.entry_station}.to("Picadilly")
    end

    it 'should not allow touch_in if balance is under minimum amount' do
    subject.top_up(0.5)
    expect { subject.touch_in(station) }.to raise_error "balance under £#{Oystercard::MINIMUM_AMOUNT}"
    end
  end

  describe "#in_journey" do
    let(:station) {"Picadilly"}
    it { is_expected.to respond_to(:in_journey?) }

    it 'returns the journey status' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject.in_journey?).to eq true
    end
  end

  describe "#touch_out" do
    let(:station) {"Picadilly"}
    it { is_expected.to respond_to(:touch_out) }

    it 'should change journey_status to false' do
    subject.top_up(10)
    subject.touch_in(station)
    expect {subject.touch_out}.to change {subject.entry_station}.to(nil)
    end

    it 'should deduct minimum_amount from balance' do
      subject.top_up(10)
      expect {subject.touch_out}.to change {subject.balance}.by(-Oystercard::MINIMUM_AMOUNT)
    end

  end

  describe "#entry_station" do
    it 'should record entry station on touch_in' do
      subject.top_up(10)
      subject.touch_in('Picadilly')
      expect(subject.entry_station).to eq('Picadilly')
    end

    it 'should forget entry station on touch_out' do
      subject.top_up(10)
      subject.touch_in('Picadilly')
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
    end
  end

end
