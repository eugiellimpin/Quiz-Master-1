require 'rails_helper'

RSpec.describe Question, type: :request do
  it 'Get all Questions' do
    headers = { "CONTENT_TYPE" => "application/json" }
    response_body = {"questions":[]}

    get "/questions", headers
    expect(response.content_type).to eq("application/json")
    expect(response).to have_http_status(:success)
    expect(response.body).to eq(response_body.to_json)
  end
end
