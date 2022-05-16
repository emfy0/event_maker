module ApplicationHelper
  def user_avatar(user)
    if user.avatar.attached?
      user.avatar.variant(:thumb)
    else
      asset_path('user.png')
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.variant(:thumb).url
    else
      asset_path('event.jpg')
    end
  end

  def bi_icon(icon_class)
    content_tag 'i', '', class: "bi bi-#{icon_class}"
  end

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-dark'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def bootstrap_flash(_opts = {})
    flash.each do |msg_type, message|
      alert_class = "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show"

      alert_div = content_tag(:div, message, class: alert_class, role: 'alert') do
        concat message
        concat content_tag(:button, '', class: 'btn-close', type: 'button',
                                        data: { 'bs-dismiss': 'alert' }, 'aria-label': 'Close')
      end
      concat(alert_div)
    end
    nil
  end
end
