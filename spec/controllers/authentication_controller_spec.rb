require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let!(:user) { User.create!(email: 'email@example.com', password: 'password', username: 'test', name: 'test') }
  describe 'POST login' do
    it 'has a 200 status code' do
      post :login, params: { email: 'email@example.com', password: 'password' }
      expect(json_body).to have_key(:token)
      expect(response.status).to eq(200)
    end
    it 'has a 401 status code' do
      post :login, params: { emaial: 'email@example.com', password: 'password' }
      expect(response.status).to eq(401)
    end
    it 'has a 401 status code' do
      post :login, params: { email: 'email@example.com', password: 'passworddd' }
      expect(response.status).to eq(401)
    end
  end
end
