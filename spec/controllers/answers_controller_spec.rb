require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create :question }

  describe 'POST #create' do
    sign_in_user
    let(:params) { { answer: attributes_for(:answer), question_id: question, format: :js } }
    let(:invalid_params) { { answer: attributes_for(:invalid_answer), question_id: question, format: :js } }

    context 'with valid attributes' do
      it 'saves new answer in database' do
        expect { post :create, params: params }.to change(question.answers, :count).by(1)
      end

      it 'assign new answer with user' do
        expect { post :create, params: params }.to change(@user.answers, :count).by(1)
      end

      it 'render template create' do
        post :create, params: params
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: invalid_params }.to_not change(Answer, :count)
      end

      it 'render templae create' do
        post :create, params: invalid_params
        expect(response).to render_template :create
      end

    end
  end

  describe 'PATCH #UPDATE' do
    let!(:answer) { create(:answer, question: question) }

    it 'assigns the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns question to @question' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, answer: { body: 'new body' },question_id: question, format: :js }
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(response).to render_template :update
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer_user) { create(:answer, question: question, user: @user) }
    let!(:answer) { create(:answer, question: question) }

    context 'author delete answer' do
      it 'delete answer' do
        expect { delete :destroy, params: { id: answer_user } }.to change(Answer, :count).by(-1)
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
