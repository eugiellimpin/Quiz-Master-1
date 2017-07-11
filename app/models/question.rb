class Question < ActiveRecord::Base


  def validate_answer answer
    submitted_answer = Question.number_to_words(answer)
    correct_answer = Question.number_to_words(self.answer)
    if submitted_answer == correct_answer
      return true
    end

    return false
  end

  def self.number_to_words answer
    if answer.nil? or answer.blank?
      return false
    end

    arr = answer.split(' ')
    number_pattern = /\A[-+]?[0-9]+\z/
    words = []

    arr.each do |a|
     is_number = number_pattern.match(a)
     if not is_number.nil?
       a = a.to_i.humanize
     end
     words.push(a)
    end
    
    return words.join(' ')
  end

end
