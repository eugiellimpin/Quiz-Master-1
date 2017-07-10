class RenameQuizesToQuestions < ActiveRecord::Migration
  def change
    rename_table :quizzes, :questions
  end
end
