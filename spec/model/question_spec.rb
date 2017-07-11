require 'rails_helper'

RSpec.describe Question, '.validate_answer' do

  it "should validate correct answer" do
    question = Question.create(question: "This is a question",
                               answer: "This is a answer")

    submitted_answer = Question.number_to_words("This is a answer")
    correct_answer = Question.number_to_words(question.answer)

    expect(correct_answer).to eq(submitted_answer)
  end

  it "should validate incorrect answer" do
    question = Question.create(question: "This is a question",
                               answer: "This is a answer")

    submitted_answer = Question.number_to_words(" is a answer")
    correct_answer = Question.number_to_words(question.answer)

    expect(correct_answer).not_to eq(submitted_answer)
  end
end

RSpec.describe Question, '#number_to_words' do

  it "should convert single number to words" do
    number = "5"
    number_in_words = Question.number_to_words(number)
    expect(number_in_words).to eq("five")
  end

  it "should convert number to words in a sentence" do
    sentence_with_number = "This is 5"
    number_in_words = Question.number_to_words(sentence_with_number)
    expect(number_in_words).to eq("This is five")
  end

  it "should handle a sentence without a number" do
    sentence = "This is a sentence"
    number_in_words = Question.number_to_words(sentence)
    expect(number_in_words).to eq("This is a sentence")
  end

  it "should handle a word without a number" do
    word = "word"
    number_in_words = Question.number_to_words(word)
    expect(number_in_words).to eq("word")
  end

  it "should handle empty parameter" do
    word = ""
    number_in_words = Question.number_to_words(word)
    expect(number_in_words).to eq(false)
  end

  it "should handle nil parameter" do
    word = nil
    number_in_words = Question.number_to_words(word)
    expect(number_in_words).to eq(false)
  end

end
