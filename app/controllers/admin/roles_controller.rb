class Admin::RolesController < Admin::ApplicationController
  def index
    @roles = Role.all
  end
end
