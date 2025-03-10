class EventOrganizersController < ApplicationController
  def create
    organizer = EventOrganizer.new(organizer_params)
    
    if organizer.save
      token = JsonWebToken.encode(user_id: organizer.id, role: 'EventOrganizer')
      render json: { token: token, role: 'EventOrganizer' }, status: :created
    else
      render json: { error: organizer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def organizer_params
    params.require(:event_organizer).permit(:name, :email, :password, :password_confirmation)
  end
end