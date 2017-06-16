require 'rails_helper'

feature 'Sign out', %q{
  In order to be abble to logout
  as authenticated user
  I want to be ablle sign out
} do

  given(:user) { create(:user) }

  scenario 'Sign out' do
    sign_in(user)

    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully'
  end
end