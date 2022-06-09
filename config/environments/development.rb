require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.hosts.clear
  config.cache_classes = false
  config.active_job.queue_adapter = :resque
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.active_storage.service = :yandex

  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_options = { from: Rails.application.credentials.dig(:yandex_mail, :user_name) }

  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_caching = false

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  config.active_job.queue_adapter = :resque
  config.active_job.queue_name_prefix = "eventmaker_#{Rails.env}"

  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  config.assets.quiet = true

  config.action_mailer.default_url_options = { host: 'localhost:3000' }
end
