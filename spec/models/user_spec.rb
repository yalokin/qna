require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:answers) }
  it { should have_many(:questions) }

  let(:user) { create :user }
  let(:question) { create(:question, user: user) }
  let(:user_without_question) { create :user }

  describe '#author_of?' do
    it 'return true if user is author of resource' do
      expect(user.author_of?(question)).to be true
    end

    it 'return false if user is not author of resource' do
      expect(user_without_question.author_of?(question)).to be false
    end
  end
end