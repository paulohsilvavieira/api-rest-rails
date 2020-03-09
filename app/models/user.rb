class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }, presence: true
  belongs_to :projects
end
