class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_question, only:  [:show, :destroy]

  def index
    @questions = Question.all
  end

  def show
     @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
    end
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question =Question.find(params[:id])
  end
end
