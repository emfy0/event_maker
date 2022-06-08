class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(event, record)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [record.user&.email]).uniq

    if record.instance_of?(Photo)
      all_emails.each { |mail| EventMailer.photo(record, mail).deliver_now }
    elsif record.instance_of?(Comment)
      all_emails.each { |mail| EventMailer.comment(record, mail).deliver_now }
    end
  end
end
