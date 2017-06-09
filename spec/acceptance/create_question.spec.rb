require 'rails_helper'

feature 'Create question', %q{
  In order ti get answer from community
  As any user
  I want to be abble to ask question
} do

  scenario 'User create question' do
    visit new_question_path
    fill_in 'Title', with: 'Title of question'
    fill_in 'Body', with: 'Text of question'
    click_on 'Create'

    expect(page).to have_content 'Title of question'
    expect(page).to have_content 'Text of question'
  end

  scenario 'The user creates an invalid question' do
    visit new_question_path
    click_on 'Create'

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Body can't be blank"
  end
end