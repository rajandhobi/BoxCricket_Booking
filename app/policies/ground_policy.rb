# class GroundPolicy
#   attr_reader :user, :ground

#   def initialize(user, ground)
#     @user = user
#     @ground = ground
#   end

#   def index?
#     true  # Everyone can view grounds
#   end

#   def show?
#     true  # Everyone can view a single ground
#   end
#   def new?
#     true
#   end

#   def edit?
#     true
#   end

#   def create?
#     user&.has_role?(:admin) || user&.has_role?(:superadmin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
#   end

#   def update?
#     user&.has_role?(:admin) || user&.has_role?(:superadmin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
#   end

#   def destroy?
#     user&.has_role?(:admin) || user&.has_role?(:superadmin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
#   end
# end


class GroundPolicy
  attr_reader :user, :ground

  def initialize(user, ground)
    @user = user
    @ground = ground
  end

  def index?
    user&.has_role?(:superadmin) || user&.has_role?(:admin)
  end

  def show?
    user&.has_role?(:superadmin) || user_owns_ground?
  end

  def new?
    user&.has_role?(:admin) || user&.has_role?(:superadmin)
  end

  def create?
    user&.has_role?(:admin) || user&.has_role?(:superadmin)
  end

  def edit?
    user&.has_role?(:superadmin) || user_owns_ground?
  end

  def update?
    user&.has_role?(:superadmin) || user_owns_ground?
  end

  def destroy?
    user&.has_role?(:superadmin) || user_owns_ground?
  end

  private

  def user_owns_ground?
    ground.user_id == user.id
  end
end
