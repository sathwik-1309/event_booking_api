class AuthenticationController < ApplicationController
  def login
    user = find_user(params[:email])

    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id, role: user.class.name)
      render json: { token: token, role: user.class.name }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def find_user(email)
    EventOrganizer.find_by(email: email) || Customer.find_by(email: email)
  end
end