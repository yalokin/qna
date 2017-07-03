class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update, :best]
  before_action :set_answer, only: [:destroy, :update, :best]
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
  end

  def update
    if current_user.author_of?(@answer)
      @question = @answer.question
      @answer.update(answer_params)
    else
      flash[:notice] = 'You can not edit this answer'
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted'
    else
      flash[:notice] = 'You can not delete this answer'
    end
  end

  def best
    @answer.best! if current_user.author_of?(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end