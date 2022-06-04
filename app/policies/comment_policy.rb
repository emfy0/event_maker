class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    user_is_comment_owner_or_event_owner?(record)
  end

  private

  def user_is_comment_owner_or_event_owner?(comment)
    user.present? &&
      ((comment.try(:user) == user) || (comment.event.try(:user) == user))
  end
end
