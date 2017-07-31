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

  scenario 'autheticated user tries to vote up for answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Vote up'
    end

    within '.vote' do
      expect(page).to have_content '1'
    end
  end

  scenario 'autheticated user tries to vote down for answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Vote down'
    end

    within '.vote' do
      expect(page).to have_content '-1'
    end
  end

  scenario 'unauthenticated user tries to vote for answer', js: true do
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link 'Vote up'
      expect(page).to have_no_link 'Vote down'
    end
  end

  scenario 'author tries to vote for his answer' do
    sign_in(answer.user)
    visit question_path(question)
    within '.answers' do
      expect(page).to have_no_link 'Vote up'
      expect(page).to have_no_link 'Vote down'
    end
  end
end