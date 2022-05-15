module ApplicationHelper
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
