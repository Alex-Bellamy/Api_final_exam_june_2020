require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:user_credentials) { user.create_new_auth_token }
  let!(:user_headers { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  let(:article) { create(:article) }

  describe 'POST /api/comments' do
    before do
      post '/api/comments', 
        params: {
          comments: {
            comment: "nice article",
            article_id: article.id
         }
        }, header: user_headers
  end

  it 'is expected to return 200 response status' do
    expect(response).to have_http_status 200
  end

  it 'is expected to return a success message' do
    expect(response_json['message']).to eq 'Your comment was successfully sent'
  end
end