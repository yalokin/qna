require_relative 'acceptance_helper'

feature 'Create question', %q{
  In order to get answer from community
  As any user
  I want to be abble to ask question
} do

  given(:user) { create :user }

  scenario 'Authenticated user can create question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask'
    fill_in 'Title', with: 'Title of question'
    fill_in 'Body', with: 'Text of question'
    click_on 'Create'

    expect(page).to have_content 'Title of question'
    expect(page).to have_content 'Text of question'
  end

  scenario 'Unauthenticated user to try create question' do
    visit questions_path
    click_on 'Ask'
    expect(page).to have_content 'You need to sign in'
  end

  scenario 'The user creates an invalid question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask'
    click_on 'Create'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end

  scenario "Questions appears on another user's page", js: true do

    Capybara.using_session('user') do
      sign_in(user)
      visit questions_path
    end

    Capybara.using_session('guest') do
      visit questions_path
    end

    Capybara.using_session('user') do
      click_on 'Ask'
      fill_in 'Title', with: 'Title of question'
      fill_in 'Body', with: 'Text of question'
      click_on 'Create'

      expect(page).to have_content 'Title of question'
      expect(page).to have_content 'Text of question'
    end

    Capybara.using_session('guest') do
      expect(page).to have_content 'Title of question'
    end
  end
end