class TicketsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_event_organizer
  before_action :set_event
  before_action :set_ticket, only: [:update, :destroy]

  def index
    tickets = @event.tickets
    render json: tickets
  end

  def create
    ticket = @event.tickets.new(ticket_params)

    if ticket.save
      render json: ticket, status: :created
    else
      render json: { error: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: { error: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket.destroy
    render json: { message: 'Ticket deleted successfully' }
  end

  private

  def authorize_event_organizer
    unless @current_user.is_a?(EventOrganizer)
      render json: { error: 'Only event organizers can manage tickets' }, status: :forbidden
    end
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_ticket
    @ticket = @event.tickets.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:price, :quantity_available, :ticket_type)
  end
end