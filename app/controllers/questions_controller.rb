class QuestionsController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def index
    questions = Question.all
    render json: { questions: questions }
  end

  def create
    quiz = Question.create(quiz_params)
    render json: { questions: Question.all, 'question': quiz }
  end

  def update
    question = Question.find(params[:id])
    question.update(quiz_params)

    render json: { questions: Question.all, 'question': question }
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    render json: {question: question }
  end

  def answer
    question = Question.find(params[:id])
    answer = quiz_params[:answer]

    if answer == question.answer
      render json: {correct: true } and return
    end

    render json: {correct: false }
  end

  private
  def quiz_params
    params.require(:quiz).permit(:question, :answer)
  end
end
