require 'rails_helper'

feature 'User sign up', %q{
  In order to abble to ask question
  As an user
  I want to be able to sign up
} do

  scenario 'Non-registered user try to sign up' do
    visit new_user_registration_path
    fill_in 'Email', with: 'newuser@test.ru'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button('Sign up')

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end