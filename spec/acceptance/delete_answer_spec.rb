require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  as answer author
  I want to delete my answers
} do

  given(:user) { create :user }
  given(:question) { create :question }
  given!(:answer) { create(:answer, user: user, question: question) }
  given(:user_without_question) { create :user }

  scenario 'Delete answer as nonauthor' do
    sign_in(user_without_question)
    visit question_path(question)

    expect(page).to have_no_content 'Delete answer'
  end

  scenario 'Delete answer as author' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete answer'

    expect(page).to have_no_content(answer.body)
  end

  scenario 'Delete answer as nonauth user' do
    visit question_path(question)
    expect(page).to have_no_content 'Delete answer'
  end
end