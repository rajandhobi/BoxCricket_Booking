class BranchPolicy
  attr_reader :user, :branch

  def initialize(user, branch)
    @user = user
    @branch = branch
  end

  def index?
    true  # Everyone can view branches
  end

  def show?
    true  # Everyone can view a single branch
  end

  def create?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end
  def new?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
    # true
  end
  def edit?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def update?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end

  def destroy?
    user&.has_role?(:admin) # Use safe navigation (`&.`) to avoid errors when `user` is nil
  end
end
