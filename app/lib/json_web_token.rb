class JsonWebToken
  SECRET_KEY = ENV['JWT_SECRET_KEY'] || 'jwt_secret_key'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body, = JWT.decode(token, SECRET_KEY)
    HashWithIndifferentAccess.new(body)
  rescue
    nil
  end
end