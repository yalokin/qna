require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to :question }
  it { should belong_to :user }

  it { should have_many :attachments }

  it { should validate_presence_of :body }

  it { should accept_nested_attributes_for :attachments }

  let(:question) { create :question }
  let!(:answer) { create :best_answer, question: question }
  let(:another_answer) { create :answer, question: question }

  describe '#best!' do
    it 'set best answer' do
      another_answer.best!
      answer.reload

      expect(another_answer).to be_best
      expect(answer).to_not be_best
    end

  end

  describe 'scopes' do
    describe '.ordered' do
      it 'best answer should be first' do
        another_answer.best!
        expect(question.answers.ordered.first).to eq another_answer
      end
    end
  end
end
