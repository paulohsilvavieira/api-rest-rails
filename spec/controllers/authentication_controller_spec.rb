require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let!(:user) { User.create!(email: 'email@example.com', password: 'password') }

  describe 'POST Login' do
    it 'has a 200 status code' do
      post :login, params: { email: 'email@example.com', password: 'password' }
      expect(json_body).to have_key(:token)
    end
  end
end
