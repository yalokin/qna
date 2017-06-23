require_relative 'acceptance_helper'

feature 'Create answer for question', %q{
  To be abble to create answers for question
} do
  given(:user) { create :user }
  given(:question) { create :question }

  scenario 'Auth user can to create answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Your answer', with: 'Answer text'
    click_on 'Answer'

    expect(page).to have_content 'Answer text'
  end

  scenario 'Unauthenticated user to try create answer' do
    visit question_path(question)
    click_on 'Answer'

    expect(page).to have_content 'You need to sign in'
  end

  scenario 'Auth user creates unvalid answer', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Answer'

    expect(page).to have_content "Body can't be blank"
  end
end