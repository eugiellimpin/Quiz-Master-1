class Question < ActiveRecord::Base


  def validate_answer(answer)
    if answer == self.answer
      return true
    end

    return false
  end
end
