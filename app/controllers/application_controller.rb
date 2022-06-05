class EventContext
  attr_reader :user, :event, :cookies, :params

  def initialize(user, event, cookies, params)
    @user = user
    @event = event
    @cookies = cookies
    @params = params
  end
end

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[password password_confirmation current_password]
    )
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def current_user_can_edit?(model)
    user_signed_in? &&
      (model.user == current_user || model.try(:event).try(:user) == current_user)
  end

  def pundit_event(user, event, cookies, params)
    EventContext.new(user, event, cookies, params)
  end

  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
