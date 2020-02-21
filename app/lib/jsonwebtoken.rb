class Jsonwebtoken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(user, exp = 24.hours.from_now)
    payload = {}
    payload[:exp] = exp.to_i
    payload[:user_id] = user
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end
