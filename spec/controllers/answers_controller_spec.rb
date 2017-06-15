require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      it 'saves new answer in database' do
        params = { answer: attributes_for(:answer), question_id: question }
        expect { post :create, params: params }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: {answer: attributes_for(:answer), question_id: question}
        expect(response).to redirect_to assigns(:question)
      end
    end

    context  'with invalid attributes' do
      it 'does not save the answer' do
        params = { answer: attributes_for(:invalid_answer), question_id: question }
        expect { post :create, params: params }.to_not change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }
        expect(response).to render_template 'questions/show'
      end

    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer_user) { create(:answer, question: question, user: @user) }
    let!(:answer) { create(:answer, question: question) }

    context 'author delete answer' do
      it 'delete answer' do
        expect { delete :destroy, params: {id: answer_user } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question' do
        delete :destroy, params: { id: answer_user }
        expect(response).to redirect_to answer_user.question
      end
    end

    context 'nonauthor tries to delete answer' do
      it 'delete answer' do
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'redirects to question' do
        delete :destroy, params: { id: answer_user }
        expect(response).to redirect_to answer.question
      end
    end
  end
end
