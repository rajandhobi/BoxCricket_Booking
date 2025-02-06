class Ground < ApplicationRecord
  belongs_to :branch

  validates :name, :location, :ground_type, :price_per_hour, :contact_number, presence: true
  validates :price_per_hour, numericality: { greater_than_or_equal_to: 0 }
  validates :contact_number, length: { is: 10 }, numericality: { only_integer: true }
  
end
