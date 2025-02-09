class Payment < ApplicationRecord
  belongs_to :booking
  validates :amount, :status, :transaction_id, presence: true
end
