# frozen_string_literal: true

require_relative 'station'

require_relative 'journey'

# Class of the oystercard, the card itself
class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance, :journey, :history, :stations

  def initialize
    @balance = 0
    @history = []
    # check on the functionality of @journey here
    @journey = nil
    @in_journey = false
    @stations = []
  end

  def top_up(amount)
    raise "Balance limit £#{MAXIMUM_BALANCE} exceeded, top up not processed" if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient credit' if @balance < Journey::MINIMUM_FARE

    @in_journey = true
    @journey = Journey.new(station)
  end

  def in_journey?
    @in_journey
  end

  def touch_out(station)
    @in_journey = false
    @journey.finish(station)
    deduct(@journey.fare)
    @history << { entry_station: @journey.entry_station, exit_station: @journey.exit_station }
  end

  def load_stations(filename)
    File.foreach(filename) do |line| 
      line.split(",") do |name, zone|
        stringname = name.to_str
        @stations << Station.new(stringname, zone)
      end
    end
  end

  private

  def deduct(amount = @journey.fare)
    @balance -= amount
  end
end
