require_relative 'acceptance_helper'

feature 'Delete files from answer', %q{
  In order to delete my answer files
  As an answer author
  I want to be abble to delete files
} do

  given(:user) { create(:user) }
  given(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }

  before do
    sign_in(user)
    answer.attachments.create(file: file)
    visit question_path(question)
  end

  scenario 'Author deletes file', js: true do
    within '.answers' do
      click_on 'Delete file'
      expect(page).to have_no_link 'spec_helper.rb'
    end
  end
end