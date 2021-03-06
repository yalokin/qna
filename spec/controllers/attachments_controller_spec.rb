require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  sign_in_user
  let(:user_question) { create(:question, user: @user) }
  let(:user_answer) { create(:answer, question: user_question, user: @user) }
  let(:answer) { create(:answer) }
  let(:question) { create(:question) }
  let(:file) { File.open("#{Rails.root}/spec/spec_helper.rb") }

  describe 'DELETE #destroy' do

    context 'Author deletes attachment' do
      it 'deletes attachment from answer' do
        user_answer.attachments.create(file: file)
        expect { delete :destroy, params: { id: user_answer.attachments.last }, format: :js }.to change(Attachment, :count).by(-1)
      end

      it 'deletes attachment from question'do
        user_question.attachments.create(file: file)
        expect { delete :destroy, params: { id: user_question.attachments.last }, format: :js }.to change(Attachment, :count).by(-1)
      end
    end

    context 'Non-author deletes attachment' do
      it 'tries to delete attachment from answer' do
        answer.attachments.create(file: file)
        expect { delete :destroy, params: { id: answer.attachments.last }, format: :js }.to_not change(Attachment, :count)
      end

      it 'tries to delete attachment from question' do
        question.attachments.create(file: file)
        expect { delete :destroy, params: { id: question.attachments.last }, format: :js }.to_not change(Attachment, :count)
      end
    end

  end

end
