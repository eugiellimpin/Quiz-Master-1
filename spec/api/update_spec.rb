require 'rails_helper'

RSpec.describe Question, type: :request do
  it 'Update existing question' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "My Answer")

    put "/questions/" + question.id.to_s, '{ "quiz": { "question":"Your Question", "answer": "Your answer" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["question"]["question"]).to eq("Your Question")
    expect(parsed_response_body["question"]["answer"]).to eq("Your answer")
  end
end
