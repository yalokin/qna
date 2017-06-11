require 'rails_helper'

feature 'Create answer for question', %q{
  To be abble to create answers for question
} do
  given(:question) { create :question }

  scenario 'User can to create answer' do
    visit question_path(question)

    fill_in 'Your answer', with: 'Answer text'
    click_on 'Answer'

    expect(page).to have_content 'Answer text'
  end
end