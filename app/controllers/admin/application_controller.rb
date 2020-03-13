class Admin::ApplicationController < ActionController::Base
  include Admin::SessionsHelper

  layout 'admin/application'
end
