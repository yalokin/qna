require 'rails_helper'

feature 'User can watch the questions', %q{
In order to be able to view questions
as a user
} do

  given!(:questions) { create_list(:question, 2) }

  scenario 'User view questions' do
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end