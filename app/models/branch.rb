class Branch < ApplicationRecord
    has_many :grounds, dependent: :destroy # A branch has multiple grounds
end
