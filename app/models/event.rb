class Event < ApplicationRecord
  has_many :tickets
  belongs_to :event_organizer
  has_many :bookings
end