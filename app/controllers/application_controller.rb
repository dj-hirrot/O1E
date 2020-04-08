class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'] if ENV['RUN_ON'] == "staging"
  include SessionsHelper
  before_action :authenticate_user?

  rescue_from Exception, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def authenticate_user?
    unless signed_in?
      store_location
      raise ActionController::RoutingError.new(params[:path])
    end
  end

  private
    def render_404(exception = nil)
      render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
    end

    def render_500(exception = nil)
      render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
    end
end
