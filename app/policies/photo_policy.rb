class PhotoPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user_is_photo_owner_or_event_owner?(record)
  end

  private

  def user_is_photo_owner_or_event_owner?(photo)
    user.present? &&
      ((photo.user == user) || (photo.event.try(:user) == user))
  end
end
