include SessionsHelper
module Admin::SessionsHelper
  def general?
    if current_user
      current_user.role_level > 0
    end
  end

  def viewer?
    if current_user
      current_user.role_level > 1
    end
  end

  def admin?
    if current_user
      current_user.role_level > 2
    end
  end

  def superadmin?
    if current_user
      current_user.role_level > 3
    end
  end
end
