class QuizesController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def index
    render json: {'quizes': Quiz.all}
  end

  def create
    quiz = Quiz.create(question: quiz_params[:question],
                       answer: quiz_params[:answer])

    render json: {'quiz': quiz}
  end

  def update
    quiz = Quiz.find(params[:id])
    quiz.update(question: quiz_params[:question],
                answer: quiz_params[:answer])

    render json: {'quiz': quiz}
  end

  def destroy
    quiz = Quiz.find(params[:id])
    quiz.destroy

    render json: {'quizes': Quiz.all}
  end


  private
  def quiz_params
    params.require(:quiz).permit(:question, :answer)
  end
end
