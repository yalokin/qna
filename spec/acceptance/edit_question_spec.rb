require_relative 'acceptance_helper'

feature 'Question editing', %q{
  In order to fix mistake
  As an aouthor of question
  I'd like to be able to edit my question
} do

  given!(:author) { create :user }
  given!(:question) { create :question, user: author }
  given!(:user) { create :user }

  scenario 'Unauthenticated user try to edit question' do
    visit question_path(question)

    expect(page).to have_no_link 'Edit'
  end

  scenario 'Edit question as an author', js: true do
    sign_in(author)
    visit question_path(question)

    within '.question' do
      click_on 'Edit question'

      fill_in 'Title', with: 'edit title'
      fill_in 'Body', with: 'edit body'
      click_on 'Save'

      expect(page).to have_no_content question.title
      expect(page).to have_no_content question.body

      expect(page).to have_content 'edit title'
      expect(page).to have_content 'edit body'
      expect(page).to have_no_selector 'textarea'
    end
  end

  scenario 'Edit answer as nonauthor' do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to have_no_link 'Edit'
    end
  end
end