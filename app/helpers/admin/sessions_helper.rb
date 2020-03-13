include SessionsHelper
module Admin::SessionsHelper
  def invalid_user
    current_user.try(:role_level_before_type_cast).to_i < 1
  end
end
