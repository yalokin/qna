require 'rails_helper'

feature 'Create answer for question', %q{
  To be abble to create answers for question
} do
  given(:user) { create :user }
  given(:question) { create :question }

  scenario 'Auth user can to create answer' do
    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'Answer text'
    click_on 'Answer'

    expect(page).to have_content 'Answer text'
  end
end