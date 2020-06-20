# # frozen_string_literal: true

# require 'journey'

# describe Journey do
#   let(:station) { double :station, zone: 1 }

#   it 'knows if a journey is incomplete' do
#     expect(subject).not_to be_complete
#   end

#   it 'has a penalty fare by default' do
#     expect(subject.fare).to eq Journey::PENALTY_FARE
#   end

#   it 'returns itself when exiting a journey' do
#     expect(subject.finish(station)).to eq(subject)
#   end

#   describe 'complete' do
#     it 'returns true if journey is complete' do
#       oystercard = Oystercard.new
#       oystercard.top_up(10)
#       oystercard.touch_in('kings cross')
#       oystercard.touch_out('angel')
#       expect(oystercard.journey.complete?).to eq true
#     end
#   end
#   describe 'fare' do
#     it 'minimum fare is charged' do
#       oystercard = Oystercard.new
#       oystercard.top_up(10)
#       oystercard.touch_in('kings cross')
#       oystercard.touch_out('angel')
#       expect(oystercard.journey.fare).to eq Journey::MINIMUM_FARE
#     end
#   end
#   describe 'fare' do
#     it 'penalty fare is charged' do
#       oystercard = Oystercard.new
#       oystercard.top_up(10)
#       oystercard.touch_in('kings cross')
#       expect(oystercard.journey.fare).to eq Journey::PENALTY_FARE
#     end
#   end
#   # describe 'fare' do
#   #   it 'penalty fare is charged' do
#   #     # we want to stub the complete method here as that's what fare relies on
#   #     allow(@fare).to receive(:complete) { true }
#   #     expect(@fare).to eq Journey::PENALTY_FARE
#   #   end
#   # end
# end
