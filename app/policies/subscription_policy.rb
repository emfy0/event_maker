class SubscriptionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user_is_subscription_owner_or_event_owner?(record)
  end

  private

  def user_is_subscription_owner_or_event_owner?(subscription)
    user.present? &&
      ((subscription.try(:user) == user) || (subscription.try(:event).try(:user) == user))
  end
end
