require_relative 'acceptance_helper'

feature 'User can watch question with answer', %q{
  To look at the question with the answers
} do

  given(:question) { create :question }
  given!(:answers) { create_list(:answer, 2, question: question) }

  scenario 'View question page with answers' do
    visit question_path(question)

    expect(page).to have_content question.title
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end

