class BookingConfirmationJob
  include Sidekiq::Job

  def perform(booking_id)
    booking = Booking.find_by_id(booking_id)

    puts "Sending email confirmation to #{booking.customer.email} for event: #{booking.event.name}"
  end
end