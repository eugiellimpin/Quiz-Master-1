require 'rails_helper'

RSpec.describe Question, type: :request do
  it 'Send a correct answer' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "My Answer")

    post "/questions/" + question.id.to_s + "/answer", '{ "quiz": { "answer": "My Answer" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["correct"]).to eq(true)
  end

  it 'Send an incorrect answer' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "My Answer")

    post "/questions/" + question.id.to_s + "/answer", '{ "quiz": { "answer": "Wrong Answer" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["correct"]).to eq(false)
  end
  
  it 'Send a correct answer in number format' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "5")

    post "/questions/" + question.id.to_s + "/answer", '{ "quiz": { "answer": "5" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["correct"]).to eq(true)
  end

  it 'Send a number correct answer in word format' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "5")

    post "/questions/" + question.id.to_s + "/answer", '{ "quiz": { "answer": "five" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["correct"]).to eq(true)
  end

  it 'Send a correct answer (number inside a sentence)' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "This is 5")

    post "/questions/" + question.id.to_s + "/answer", '{ "quiz": { "answer": "This is 5" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["correct"]).to eq(true)
  end

  it 'Send a correct answer (word number inside a sentence)' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "This is 5")

    post "/questions/" + question.id.to_s + "/answer", '{ "quiz": { "answer": "This is five" } }', headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)

    parsed_response_body =  JSON.parse(response.body)
    expect(parsed_response_body["correct"]).to eq(true)
  end
end
