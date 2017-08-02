require 'rails_helper'

RSpec.shared_examples 'votable' do
  let(:model) { described_class }
  let(:votable) { create(model.to_s.underscore.to_sym) }
  let(:user) { create(:user) }

  describe '#vote_up' do
    it 'should set vote +1 to votable' do
      votable.vote(user, 1)
      expect(Vote.last.value).to eq 1
    end

    it 'should increment votable rating' do
      votable.vote(user, 1)
      expect(votable.rating).to eq 1
    end
  end

  describe '#vote_down' do
    it 'should set vote -1 to votable' do
      votable.vote(user, -1)
      expect(Vote.last.value).to eq -1
    end

    it 'should decrement votable rating' do
      votable.vote(user, -1)
      expect(votable.rating).to eq -1
    end
  end
end