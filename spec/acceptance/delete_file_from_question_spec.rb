require_relative 'acceptance_helper'

feature 'Delete files from question', %q{
  In order to delete my question files
  As an question author
  I want to be abble to delete files
} do

  given(:user) { create(:user) }
  given(:question) { create :question, user: user }
  given!(:attachment) { create(:attachment, attachable: question) }

  scenario 'Author deletes file', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      click_on 'Delete file'
      expect(page).to have_no_link 'spec_helper.rb'
    end
  end

  scenario 'Non-author try to delete file', js: true do
    visit question_path(question)

    within '.question' do
      expect(page).to have_no_link 'Delete file'
    end
  end
end