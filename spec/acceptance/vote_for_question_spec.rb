require_relative 'acceptance_helper'

feature 'Vote for question', %q{
  In order to vote
  As an authenticated user
  I want to be abble to vote for question
} do

  given(:user) { create :user }
  given(:question) { create :question }
  given(:author_question) { create(:question, user: user) }

  scenario 'autheticated user tries to vote up for question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Vote up'
    end

    within '.question-rating' do
      expect(page).to have_content '1'
    end
  end

  scenario 'autheticated user tries to vote down for question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Vote down'
    end

    within '.question-rating' do
      expect(page).to have_content '-1'
    end
  end

  scenario 'unauthenticated user tries to vote for question', js: true do
    visit question_path(question)

    within '.question' do
      expect(page).to have_no_link 'Vote up'
      expect(page).to have_no_link 'Vote down'
    end
  end

  scenario 'author tries to vote for his question' do
    sign_in(user)
    visit question_path(author_question)
    within '.question' do
      expect(page).to have_no_link 'Vote up'
      expect(page).to have_no_link 'Vote down'
    end
  end
end