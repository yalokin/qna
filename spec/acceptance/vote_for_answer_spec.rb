require_relative 'acceptance_helper'

feature 'Vote for answer', %q{
  In order to vote
  As an authenticated user
  I want to be abble to vote for answer
} do
  given(:author) { create :user }
  given(:user) { create :user }
  given(:question) { create :question }
  given!(:answer) { create :answer, user: author, question: question }

  scenario 'User vote up for answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Vote up'
    end

    save_and_open_page
    within '.vote' do
      expect(page).to have_content '1'
    end
  end
end