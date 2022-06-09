class User < ActiveRecord::Base
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [50, 50]
  end

  validates :name, presence: true, length: { maximum: 35 }
  validates :avatar, content_type: %i[img png jpg jpeg]

  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[vkontakte yandex]

  class << self
    def find_for_vk_oauth(access_token)
      standart_find_for_oauth(access_token)
    end

    def find_for_yandex_oauth(access_token)
      standart_find_for_oauth(access_token)
    end

    private

    def standart_find_for_oauth(access_token)
      email = access_token.info.email

      user = where(email: email).first
      return user if user.present?

      provider = access_token.provider
      provider_id = access_token.extra.raw_info.id
      name = access_token.info.name

      where(provider_id: provider_id, provider: provider).first_or_create! do |user|
        user.name = name
        user.email = email
        user.password = Devise.friendly_token.first(16)
      end
    end
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  private

  def set_name
    self.name = "Пользователь #{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
