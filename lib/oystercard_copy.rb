# frozen_string_literal: true

require_relative 'journey'

# Class of the oystercard, the card itself
class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :history


  def initialize
    @balance = 0
    @history = []
    @journey_count = 0
  end

  def entry_station
    @history[@journey_count][:entry_station]
  end

  def exit_station
    @history[@journey_count][:exit_station]
  end

  def top_up(amount)
    raise "Balance limit £#{MAXIMUM_BALANCE} exceeded, top up not processed" if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient credit' if @balance < Journey::MINIMUM_FARE
    # starts a hash for the journey
    @history << {entry_station: station}
  end

  def in_journey?
    # if the journey has been started, it'll count that, if it's been finished the array index will be empty
    !!@history[@journey_count]
  end

  def touch_out(station)
    deduct
    # adds the exit station to the current journey
    @history[@journey_count].store(:exit_station, station)
    @journey_count += 1
  end

  private

  def deduct(amount = Journey::MINIMUM_FARE)
    @balance -= amount
  end
end
