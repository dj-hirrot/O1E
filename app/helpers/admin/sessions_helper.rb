include SessionsHelper
module Admin::SessionsHelper
  def viewer?
    if current_user
      current_user.role_level_before_type_cast > 0
    end
  end

  def admin?
    if current_user
      current_user.role_level_before_type_cast > 1
    end
  end

  def superadmin?
    if current_user
      current_user.role_level_before_type_cast > 2
    end
  end
end
