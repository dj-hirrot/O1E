class Admin::ApplicationController < ActionController::Base
  include Admin::SessionsHelper
  rescue_from ActionController::RoutingError, with: :render_404

  before_action :admin?

  layout 'admin/application'

  def admin?
    if !signed_in? || !admin_user
      raise ActionController::RoutingError.new(params[:path])
    end
  end

  def render_404(exception = nil)
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
end
