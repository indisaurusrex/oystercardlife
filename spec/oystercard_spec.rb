# frozen_string_literal: true

require './lib/oystercard_copy'

describe Oystercard do
  # double so that station class doesn't have to exist in these tests
  let(:station) { double :station }

  # check that the balance is £0 when the card is brand new
  it 'has 0 by default' do
    expect(subject.balance).to eq 0
  end

  # check that there is an empty list for history when the card is brand new
  it 'starts with an empty history' do
    expect(subject.history).to eq([])
  end

  # check it can respond to the top up method with an argument
  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
  # adds the amount specified in top up argument to the balance
    it 'adds the amount to the balance' do
      expect { subject.top_up 4 }.to change { subject.balance }.by 4
    end

  # won't let you add top up if it'll take balance over £90
    it 'stops user from topping up over balance limit' do
      expect { subject.top_up(Oystercard::MAXIMUM_BALANCE + 1) }.to(
        raise_error "Balance limit £#{Oystercard::MAXIMUM_BALANCE} exceeded, top up not processed")
    end
  end

  # when the card is new, it should bring back false for in_journey?
  it 'is not initiated in journey' do
    expect(subject).not_to be_in_journey
  end

  # checks that if you give it credit and touch in with a station, the card will be in journey
  it 'can touch in' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  # will respond to touch_out method with an argument
  it { is_expected.to respond_to(:touch_out).with(1).argument }

  # will set in_journey to false if you touch out at a station after touching in and topping up 
  it 'allows you to touch out' do
    subject.top_up(1)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.in_journey?).to eq false
  end

  # takes min fare from balance if touch in and touch out with station
  it 'deducts the fare from balance' do
    subject.top_up(1)
    subject.touch_in(station)
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-Journey::MINIMUM_FARE)
  end

  # completes journey in the history array at touch out
  it 'stores complete journeys in history' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.history.length).to eq 1
  end
end
