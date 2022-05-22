module EventMailerHelper
  def time_phrase(time)
    time > Time.now ? t('event.will_take_place') : t('event.was_in')
  end
end
