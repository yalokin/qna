require 'rails_helper'

shared_examples_for 'voted' do

  let(:resource) { controller.controller_name.singularize.to_sym }
  let(:votable) { create(resource) }
  describe 'PATCH #vote_up' do

    context 'authenticated user tries to vote up resource' do
      sign_in_user

      it 'set vote up to resource' do
        expect { patch :vote_up, params: { id: votable }, format: :json }.to change(Vote, :count).by(1)
      end

      it 'increment rating' do
        patch :vote_up, params: { id: votable}, format: :json
        votable.reload
        expect(votable.rating).to eq 1
      end

      it 'tries vote up twice' do
        patch :vote_up, params: { id: votable }, format: :json
        expect { patch :vote_up, params: { id: votable }, format: :json }.to_not change(Vote, :count)
      end
    end

    context 'unauthenticated user tries to vote up resource' do
      it 'not set vote up to resource' do
        patch :vote_up, params: { id: votable }, format: :json
        votable.reload
        expect(votable.rating).to eq 0
      end
    end
  end

  describe 'PATCH #vote_down' do
    context 'authenticated user tries to vote down resource' do
      sign_in_user

      it 'set vote down to resource' do
        expect { patch :vote_down, params: { id: votable }, format: :json }.to change(Vote, :count).by(1)
      end

      it 'decrement rating' do
        patch :vote_down, params: {id: votable }, format: :json
        votable.reload
        expect(votable.rating).to eq -1
      end

      it 'tries vote down twice' do
        patch :vote_down, params: { id: votable }, format: :json
        expect { patch :vote_down, params: { id: votable }, format: :json }.to_not change(Vote, :count)
      end
    end

    context 'unauthenticated user tries to vote down resource' do
      it 'not set vote down to resource' do
        patch :vote_down, params: { id: votable }, format: :json
        votable.reload
        expect(votable.rating).to eq 0
      end
    end
  end

  describe 'PATCH #cancel_vote' do
    sign_in_user
    context 'user cancel vote' do
      it 'removes rating changes' do
        patch :vote_up, params: { id: votable }, format: :json
        patch :cancel_vote, params: { id: votable }, format: :json
        votable.reload
        expect(votable.rating).to eq 0
      end
    end
  end
end