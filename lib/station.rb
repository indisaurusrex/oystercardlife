# frozen_string_literal: true

# to create a station instance which will be used to show where your journey starts and ends
class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end
