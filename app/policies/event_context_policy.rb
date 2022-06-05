class EventContextPolicy < ApplicationPolicy
  def show?
    password_guard!(record)
  end

  class InvalidPincode < StandardError; end

  private

  def password_guard!(event_context)
    return true if event_context.event.pincode.blank?
    return true if event_context.user.present? && event_context.user == event_context.event.user

    if event_context.params[:pincode].present? && event_context.event.pincode_valid?(event_context.params[:pincode])
      event_context.cookies.permanent["events_#{event_context.event.id}_pincode"] = event_context.params[:pincode]
    end

    pincode = event_context.cookies.permanent["events_#{event_context.event.id}_pincode"]
    unless event_context.event.pincode_valid?(pincode)
      raise EventContextPolicy::InvalidPincode
    end

    true
  end
end
