# frozen_string_literal: true

# Journeys are created within the oystercard instance, and are stored in history
class Journey
  attr_accessor :entry_station, :exit_station
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

  def finish(station)
    @exit_station = station
    self
  end
end
