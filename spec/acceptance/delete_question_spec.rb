require 'rails_helper'

feature 'Delete question by author', %q{
  In order to delete question
  As question author
  I want to delete my questions
} do

  given!(:user) { create :user }
  given!(:question) { create(:question, user: user) }
  given!(:user_without_question) { create :user }

  scenario 'Delete question as nonauthor' do
    sign_in(user_without_question)
    visit question_path(question)
    expect(page).to_not have_content 'Delete'
  end

  scenario 'Delete question as author' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'
    expect(page).to_not have_content (question.title)
  end

  scenario 'Delete question as an nonauth user' do
    visit question_path(question)
    expect(page).to_not have_content 'Delete question'
  end
end