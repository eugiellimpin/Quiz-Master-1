require 'rails_helper'

RSpec.describe Question, type: :request do
  it 'Delete specific Question' do
    headers = { "CONTENT_TYPE" => "application/json" }
    question = Question.create(question: "My Question", answer: "My Answer")

    delete "/questions/" + question.id.to_s, headers
    expect(response).to have_http_status(:no_content)
  end
end
