class Branch < ApplicationRecord
    belongs_to :user , optional: true 
    #

    has_many :grounds, dependent: :destroy # A branch has multiple grounds
    validates :city, presence: true


    def self.ransackable_attributes(auth_object = nil)
        ["city", "created_at", "id", "updated_at", "user_id"]
      end
end
