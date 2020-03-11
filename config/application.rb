require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module O1e
  class Application < Rails::Application
    config.load_defaults 6.0
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
  end
end
