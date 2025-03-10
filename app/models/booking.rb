class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :ticket
  belongs_to :customer
end