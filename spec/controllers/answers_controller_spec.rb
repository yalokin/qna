require 'rails_helper'
require_relative 'concerns/votable_spec.rb'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create :question }

  it_behaves_like 'votable'

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

  describe 'PATCH #update' do
    sign_in_user
    let!(:answer) { create(:answer, question: question) }
    let!(:answer_user) { create(:answer, question: question, user: @user) }

    it 'assigns the requested answer to @answer' do
      patch :update, params: { id: answer_user, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(assigns(:answer)).to eq answer_user
    end

    it 'assigns question to @question' do
      patch :update, params: { id: answer_user, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer_user, answer: { body: 'new body' },question_id: question, format: :js }
      answer_user.reload
      expect(answer_user.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { id: answer_user, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(response).to render_template :update
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let!(:answer_user) { create(:answer, question: question, user: @user) }
    let!(:answer) { create(:answer, question: question) }

    context 'author delete answer' do
      it 'delete answer' do
        expect { delete :destroy, params: { id: answer_user, format: :js } }.to change(Answer, :count).by(-1)
      end

      it 'render destroy template' do
        delete :destroy, params: { id: answer_user, format: :js }
        expect(response).to render_template :destroy
      end
    end

    context 'nonauthor tries to delete answer' do
      it 'delete answer' do
        expect { delete :destroy, params: { id: answer, format: :js } }.to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #best' do
    sign_in_user
    let(:question_user) { create :question, answers: create_list(:answer, 2), user: @user }
    let(:question) { create :question, answers: create_list(:answer, 2) }

    context 'makes answer best'do
      it 'set best to true' do
        patch :best, params: { id: question_user.answers.first, format: :js }

        expect(assigns(:answer)).to be_best
      end

      it 'renders best template' do
        patch :best, params: { id: question_user.answers.first, format: :js }
        expect(response).to render_template :best
      end
    end

    context 'no author of question try to set best answer' do
      it 'best is not set' do
        patch :best, params: { id: question.answers.first, format: :js }
        expect(assigns(:answer)).to_not be_best
      end
    end
  end
end