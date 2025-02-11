class BookingPolicy < ApplicationPolicy
  def create?
    user.present? # Only signed-in users can book
  end
  def book?
    user.present?
  end
  

  def destroy?
    user.present? && record.user == user
  end
end
