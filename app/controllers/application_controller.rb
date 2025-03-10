class ApplicationController < ActionController::API

  def authenticate_user!
    header = request.headers['Authorization']
    return render json: { error: 'Token missing' }, status: :unauthorized if header.blank?

    begin
      decoded = JsonWebToken.decode(header.split(' ').last)
      if decoded[:role] == 'EventOrganizer'
        @current_user = EventOrganizer.find(decoded[:user_id])
      elsif decoded[:role] == 'Customer'
        @current_user = Customer.find(decoded[:user_id])
      else
        render json: { error: 'Invalid role' }, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end