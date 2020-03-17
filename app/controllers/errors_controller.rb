class ErrorsController < ActionController::Base
  def error
    rescue_from Exception, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  def render_404(exception = nil)
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def render_500(exception = nil)
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  end
end