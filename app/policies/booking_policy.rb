class BookingPolicy < ApplicationPolicy
  def create?
    user.present? # Only signed-in users can book
  end
  def book?
    user.present?
  end
  

  def destroy?
    # user.present? && record.user == user
    user.present? && (record.user == user || user.has_role?(:admin) || user.has_role?(:super_admin))

  end
end
