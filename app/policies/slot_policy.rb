class SlotPolicy
  attr_reader :user, :slot

  def initialize(user, slot)
    @user = user
    @slot = slot
  end

  def new?
    true
  end

  def create?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def update?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def destroy?
    user&.has_role?(:admin) || record.user == user
  end
end
