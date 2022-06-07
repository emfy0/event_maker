require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = false
  config.assets.compile = false
  config.active_storage.service = :yandex

  config.log_level = :info
  config.log_tags = [ :request_id ]

  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.default_options = { from: 'no-reply@emfy0.xyz' }

  config.i18n.fallbacks = true

  config.active_support.report_deprecations = false

  config.log_formatter = ::Logger::Formatter.new

  config.active_job.queue_adapter = :resque
  config.active_job.queue_name_prefix = "eventmaker_#{Rails.env}"

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false

  config.action_mailer.default_url_options = { host: 'emfy0.xyz' }
end
