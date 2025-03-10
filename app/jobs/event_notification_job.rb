class EventNotificationJob
  include Sidekiq::Job

  def perform(event_id)
    event = Event.find(event_id)
    customers = Booking.where(event_id: event.id).map(&:customer)

    customers.each do |customer|
      puts "Notifying #{customer.email} about event update: #{event.name}"
    end
  end
end