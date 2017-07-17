require_relative 'acceptance_helper'

feature 'Delete files from answer', %q{
  In order to delete my answer files
  As an answer author
  I want to be abble to delete files
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }
  given!(:attachment) { create(:attachment, attachable: answer ) }

  scenario 'Author deletes file', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      click_on 'Delete file'
      expect(page).to have_no_link 'spec_helper.rb'
    end
  end

  scenario 'Non-author try to delete file', js: true do
    visit question_path(question)

    within '.answers' do
      expect(page).to have_no_link 'Delete file'
    end
  end
end