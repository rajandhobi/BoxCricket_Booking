class GroundPolicy
  attr_reader :user, :ground

  def initialize(user, ground)
    @user = user
    @ground = ground
  end

  def index?
    true  # Everyone can view grounds
  end

  def show?
    true  # Everyone can view a single ground
  end
  def new?
    true
  end

  def edit?
    true
  end

  def create?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def update?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def destroy?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end
end
