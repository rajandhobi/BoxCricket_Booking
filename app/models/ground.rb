class Ground < ApplicationRecord
  belongs_to :branch
  has_many :slots, dependent: :destroy
  accepts_nested_attributes_for :slots, allow_destroy: true


  validates :name, :location, :ground_type, :price_per_hour, :contact_number, presence: true
  validates :price_per_hour, numericality: { greater_than_or_equal_to: 0 }
  validates :contact_number, length: { is: 10 }, numericality: { only_integer: true }


  has_one_attached :image do |attachable|
    attachable.variant :thumb,resize_to_limit: [300,300]
  end
  
end
