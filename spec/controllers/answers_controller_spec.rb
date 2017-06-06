require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create :question }

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
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
  end
end
