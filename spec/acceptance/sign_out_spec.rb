require 'rails_helper'

feature 'Sign out', %q{
  In order to be abble to logout
  as authenticated user
  I want to be ablle sign out
} do

  given(:user) { create(:user) }

  scenario 'Sign out' do

    User.create!(email: 'user@test.ru', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.ru'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
  end
end