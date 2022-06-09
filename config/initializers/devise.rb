# frozen_string_literal: true

# Assuming you have not yet modified this file, each configuration option below
# is set to its default value. Note that some are commented out while others
# are not: uncommented lines are intended to protect your configuration from
# breaking changes in upgrades (i.e., in the event that future versions of
# Devise change the default values for those options).
#
# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  require 'devise/orm/active_record'

  omniauth_vk_id = Rails.application.credentials[Rails.env.to_sym][:omniauth_vk_id]
  omniauth_vk_secret = Rails.application.credentials[Rails.env.to_sym][:omniauth_vk_secret]

  config.omniauth :vkontakte, omniauth_vk_id, omniauth_vk_secret, { scope: 'email' }

  omniauth_ya_id = Rails.application.credentials[Rails.env.to_sym][:omniauth_ya_id]
  omniauth_ya_secret = Rails.application.credentials[Rails.env.to_sym][:omniauth_ya_secret]

  config.omniauth :yandex, omniauth_ya_id, omniauth_ya_secret

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 12

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete
end
