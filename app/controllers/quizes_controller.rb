class QuizesController < ApplicationController

  skip_before_filter  :verify_authenticity_token

  def index
    @quizes = Quiz.all
    render component: 'Quizes', props: { quizes: @quizes }
  end

  def create
    @quiz = Quiz.new(quiz_params)
    respond_to do |format|
      format.json do
        if @quiz.save
          render json: @quiz
        else
          render json: {errors: @quiz.errors.messages}, status: 422
        end
      end
    end
  end

  def update
    @quiz = Quiz.find(params[:id])
    respond_to do |format|
      format.json do
        if @quiz.update(quiz_params)
          render json: @quiz
        else
          render json: {errors: @quiz.errors.messages}, status: 422
        end
      end
    end
  end

  def destroy
    quiz = Quiz.find(params[:id])
    quiz.destroy
    respond_to do |format|
      format.json { render :json => {}, :status => :no_content }
    end
  end

  private
  def quiz_params
    params.require(:quiz).permit(:question, :answer)
  end
end
