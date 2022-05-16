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
         :recoverable, :rememberable, :validatable

  private

  def set_name
    self.name = "Пользователь #{rand(777)}" if name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
