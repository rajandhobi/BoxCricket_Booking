class Ground < ApplicationRecord
  belongs_to :branch
  belongs_to :user  # Each ground is created by one user (admin)

  has_many :slots, dependent: :destroy
  accepts_nested_attributes_for :slots, allow_destroy: true


  validates :name, :location,:contact_number, presence: true
  validates :contact_number, length: { is: 10 }, numericality: { only_integer: true }


  has_one_attached :image do |attachable|
    attachable.variant :thumb,resize_to_limit: [300,300]
  end
  
end
