Rails.configuration.exceptions_app = ->(env) { ErrorsController.action(:error).call(env) }
