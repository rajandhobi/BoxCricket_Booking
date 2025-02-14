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
    user&.has_role?(:superadmin) || user_created_ground? || !user&.has_role?(:admin)
  end
  def new?
    user&.has_role?(:admin) || user&.has_role?(:superadmin) 
  end

  def edit?
    user&.has_role?(:superadmin) || (user&.has_role?(:admin) && user_created_ground?)

  end

  def create?
    user&.has_role?(:admin) || user&.has_role?(:superadmin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def update?
    user&.has_role?(:superadmin) || (user&.has_role?(:admin) && user_created_ground?)
  end

  def destroy?
    user&.has_role?(:superadmin) || (user&.has_role?(:admin) && user_created_ground?)
  end

  private

  def user_created_ground?
    ground.user_id == user.id # Assuming `Ground` has a `user_id` field linking it to the creator
  end

end

