require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { User.create!(email: 'email@example.com', password: 'password', username: 'test', name: 'test') }
  let!(:user_test) { User.create!(email: 'email2@example.com', password: 'password', username: 'test2', name: 'test') }

  let!(:token) { Jsonwebtoken.encode(user.id) }

  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Authorization' => "Bearer #{token}"
    }
  end

  describe 'GET index' do
    it 'has a 200 status code' do
      request.headers.merge! headers
      get :index
      expect(json_body).to have_key(:users)
      expect(response.status).to eq(200)
    end

    it 'has a 401 status code' do
      get :index
      expect(response.status).to eq(401)
    end
  end

  describe 'GET show' do
    it 'has a 200 status code' do
      request.headers.merge! headers
      get :show, params: { username: user_test.username }
      expect(json_body).to have_key(:email)
      expect(response.status).to eq(200)
    end
    it 'has a 404 status code' do
      request.headers.merge! headers
      get :show, params: { username: 'asdas' }
      expect(response.status).to eq(404)
    end
    it 'has a 401 status code' do
      get :show, params: { username: '' }
      expect(response.status).to eq(401)
    end
  end
  describe 'POST create' do
    it 'has a 201 status code' do
      post :create, params: { email: 'email3@example.com', password: 'password2', username: 'test3', name: 'test3' }
      expect(json_body).to have_key(:email)
      expect(response.status).to eq(201)
    end
    it 'has a 422 status code' do
      post :create, params: { email: 'email3@example.com' }
      expect(response.status).to eq(422)
    end
  end
end
