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
    user&.has_role?(:superadmin) # Only Super Admins can create branches
  end
  def new?
    user&.has_role?(:admin) || user&.has_role?(:superadmin) # Only Super Admins can create branches
    # true
  end
  def edit?
    user&.has_role?(:superadmin) # Only Super Admins can edit branches  end
  end
  def update?
    user&.has_role?(:superadmin) # Only Super Admins can edit branches  end
  end
  def destroy?
    user&.has_role?(:superadmin) # Only Super Admins can delete
  end
end
