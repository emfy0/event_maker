class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email,
            presence: true,
            format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/,
            unless: -> { user.present? }

  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  validate :owner_cant_be_subscriber

  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }
  validate :unauthorized_users_cant_use_registred_mails, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def owner_cant_be_subscriber
    errors.add(:user) if user == event.user
  end

  def unauthorized_users_cant_use_registred_mails
    errors.add(:user_email, I18n.t('errors.has_been_registered')) unless User.find_by(email: user_email).nil?
  end
end
