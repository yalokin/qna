require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  sign_in_user
  let(:user_question) { create(:question, user: @user) }
  let(:user_answer) { create(:answer, question: user_question, user: @user) }
  let(:answer) { create(:answer) }

  describe 'DELETE #destroy' do

    before do
      file = File.open("#{Rails.root}/spec/spec_helper.rb")
      user_question.attachments.create(file: file)
      user_answer.attachments.create(file: file)
      answer.attachments.create(file: file)
    end

    context 'Author deletes attachment' do
      it 'deletes attachment from answer' do
        expect { delete :destroy, params: {id: user_answer.attachments.last }, format: :js }.to change(Attachment, :count).by(-1)
      end
    end

    context 'Non-author deletes attachment' do
      it 'deletes attachment from answer' do
        expect { delete :destroy, params: { id: answer.attachments.last }, format: :js }.to_not change(Attachment, :count)
      end
    end

  end

end
