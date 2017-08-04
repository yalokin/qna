require 'rails_helper'

RSpec.shared_examples 'votable' do
  let(:model) { described_class }
  let(:votable) { create(model.to_s.underscore.to_sym) }
  let(:user) { create(:user) }

  describe '#vote(user, 1)' do
    it 'should set vote +1 to votable' do
      votable.vote(user, 1)
      expect(votable.vote_by(user).value).to eq 1
    end

    it 'should increment votable rating' do
      votable.vote(user, 1)
      expect(votable.rating).to eq 1
    end
  end

  describe '#vote(user, -1)' do
    it 'should set vote -1 to votable' do
      votable.vote(user, -1)
      expect(votable.vote_by(user).value).to eq -1
    end

    it 'should decrement votable rating' do
      votable.vote(user, -1)
      expect(votable.rating).to eq -1
    end
  end

  describe '#cancel_vote' do
    it 'should clear users vote' do
      votable.vote(user, 1)
      expect { votable.cancel_vote(user) }.to change(votable.votes, :count).by(-1)
    end
  end

  describe '#vote_by' do
    it 'should return user vote' do
      votable.vote(user, 1)
      expect(votable.vote_by(user).user_id).to eq user.id
    end
  end
end