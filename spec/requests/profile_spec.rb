require 'rails_helper'

RSpec.describe 'User', type: :request do
  let!(:user) { User.create!(email: 'email@example.com', password: 'password', username: 'test', name: 'test') }
  let!(:token) { Jsonwebtoken.encode(user.id) }
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => "Bearer #{token}"
    }
  end
  context 'PUT /user/profile' do
    it 'has a 204 status code' do
      put '/users/profile', headers: headers, params: { username: 'email3@example.com' }.to_json
      expect(response.status).to eq(204)
    end

    it 'has a 422 status code' do
      put '/users/profile', headers: headers, params: { username: nil }.to_json
      expect(response.status).to eq(422)
    end

    it 'has a 401 status code' do
      put '/users/profile', params: { username: 'email3@example.com' }.to_json
      expect(response.status).to eq(401)
    end
  end

  context 'DELETE /user/profile' do
    it 'has a 204 status code' do
      delete '/users/profile', headers: headers
      expect(response.status).to eq(204)
    end

    it 'has a 401 status code' do
      delete '/users/profile'
      expect(response.status).to eq(401)
    end
  end
end
