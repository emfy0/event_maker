class EventPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def create?
    new?
  end

  def update?
    user_is_owner?(record)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def show?
    true
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end
end
