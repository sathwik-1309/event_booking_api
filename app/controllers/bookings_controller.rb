class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_customer

  def create
    event = Event.find(params[:event_id])
    ticket = event.tickets.find(params[:ticket_id])
    quantity = params[:quantity].to_i

    if ticket.quantity_available <= 0
      return render json: { error: 'Ticket is sold out' }, status: :unprocessable_entity
    end

    total_price = quantity * ticket.price
    booking = Booking.new(event: event, ticket: ticket, quantity: quantity, customer_id: @current_user.id, total_price: total_price)

    if booking.save
      ticket.quantity_available -= quantity
      ticket.save!
      BookingConfirmationJob.perform_async(booking.id)
      render json: booking, status: :created
    else
      render json: { error: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    bookings = @current_user.bookings.includes(:event, :ticket)
    render json: bookings.as_json(include: [:event, :ticket])
  end

  private

  def authorize_customer
    unless @current_user.is_a?(Customer)
      render json: { error: 'Only customers can book tickets' }, status: :forbidden
    end
  end
end