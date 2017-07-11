require 'rails_helper'

RSpec.describe Question, type: :request do
  it 'Create a new Question' do
    headers = { "CONTENT_TYPE" => "application/json" }

    post "/questions", '{ "quiz": { "question":"My Question", "answer": "My answer" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:created)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["question"]["question"]).to eq("My Question")
    expect(parsed_response_body["question"]["answer"]).to eq("My answer")
  end
end
