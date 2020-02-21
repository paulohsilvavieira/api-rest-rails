require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with invalid attributes' do
    expect(User.new).to be_invalid
  end
  it 'Name is Empty' do
    expect(User.new(name: nil, email: 'test@email.com', password_digest: 'teste', username: 'test')).to be_invalid
  end
  it 'Username is empty' do
    expect(User.new(name: 'test', email: 'test@email.com', password_digest: 'teste', username: nil)).to be_invalid
  end
  it 'Email is Empty' do
    expect(User.new(name: 'test', email: nil, password_digest: 'teste', username: nil)).to be_invalid
  end

  it 'Email is not Valid' do
    expect(User.new(name: 'test', email: 'nil', password_digest: 'teste', username: 'test')).to be_invalid
  end

  it'Password is empty' do
    expect(User.new(name: 'test', email: 'nil', password_digest: nil, username: 'test')).to be_invalid
  end

  it 'Password is length invalid' do
    expect(User.new(name: 'test', email: 'nil', password_digest: '123', username: 'test')).to be_invalid
  end
end
