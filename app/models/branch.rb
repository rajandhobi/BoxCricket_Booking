class Branch < ApplicationRecord
    # belongs_to :user
    #

    has_many :grounds, dependent: :destroy # A branch has multiple grounds
    validates :city, presence: true

end
