class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.find_for_vk_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Vkontakte')
      sign_in_and_redirect @user, event: :authentication
    else
      omniauth_failure
    end
  end

  def yandex
    @user = User.find_for_yandex_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Yandex')
      sign_in_and_redirect @user, event: :authentication
    else
      omniauth_failure
    end
  end

  private

  def omniauth_failure
    flash[:error] = I18n.t('omniauth.failure')
    redirect_to new_user_registration_path
  end
end
