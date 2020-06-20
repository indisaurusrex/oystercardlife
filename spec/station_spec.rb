# frozen_string_literal: true

require './lib/station'

describe Station do
  let(:station) { Station.new('station_name', 'zone') }
  describe 'creates the station' do
    it 'creates an station instance' do
      expect(station).to be_an_instance_of(Station)
    end
  end

  describe 'name' do
    it 'shows the station name' do
      expect(station.name).to eq('station_name')
    end
  end

  describe 'zone' do
    it 'shows the zone' do
      expect(station.zone).to eq('zone')
    end
  end
end
