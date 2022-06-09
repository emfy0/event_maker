require 'rails_helper'

RSpec.describe SubscriptionPolicy do
  let(:user) { User.new }

  subject { SubscriptionPolicy }

  context 'user in not authorized' do
    let(:event) { Event.new(user: user) }
    let(:subscription) { Subscription.new(event: event) }

    permissions :create? do
      it { is_expected.to permit(nil, Subscription) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(nil, subscription) }
    end
  end

  context 'user is subscription owner' do
    let(:another_user) { User.new }
    let(:event) { Event.new(user: another_user) }
    let(:subscription) { Subscription.new(event: event, user: user) }

    permissions :create?, :destroy? do
      it { is_expected.to permit(user, subscription) }
    end
  end

  context 'user is event owner' do
    let(:another_user) { User.new }
    let(:event) { Event.new(user: user) }
    let(:subscription) { Subscription.new(event: event, user: another_user) }

    permissions :create? do
      it { is_expected.to permit(user, Subscription) }
    end

    permissions :destroy? do
      it { is_expected.to permit(user, subscription) }
    end
  end

  context 'user is not a subscription owner' do
    let(:another_user) { User.new }
    let(:event) { Event.new(user: another_user) }
    let(:subscription) { Subscription.new(event: event, user: another_user) }

    permissions :create? do
      it { is_expected.to permit(user, Subscription) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(user, subscription) }
    end
  end
end
