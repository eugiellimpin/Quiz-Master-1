class QuestionsController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def index
    questions = Question.all
    render json: { questions: questions }, status: 200
  end

  def create
    quiz = Question.create(quiz_params)
    render json: { questions: Question.all, 'question': quiz }, status: 201
  end

  def update
    question = Question.find(params[:id])
    question.update(quiz_params)

    render json: { questions: Question.all, 'question': question }, status: 200
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    render json: { }, status: 204
  end

  def answer
    question = Question.find(params[:id])
    answer = quiz_params[:answer]
    valid_answer = question.validate_answer(answer)

    if valid_answer
      render json: {correct: true }, status: 200 and return
    end

    render json: {correct: false }, status: 200
  end

  private
  def quiz_params
    params.require(:quiz).permit(:question, :answer)
  end
end
