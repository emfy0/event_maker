require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user) { User.new }

  subject { EventPolicy }

  context 'user is not authotized' do
    permissions :new?, :create?, :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(nil, Event) }
    end
  end

  context 'user is event owner' do
    let(:event) { Event.new(user: user) }

    permissions :new?, :create?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, event) }
    end
  end

  context 'user is not event owner' do
    let(:event) { Event.new }

    permissions :new?, :create? do
      it { is_expected.to permit(user, event) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(user, event) }
    end
  end

  context 'event has no pincode' do
    let(:event_context) { EventContext.new(event: Event.new, pincode: nil) }

    context 'and user is not logged in' do
      permissions :show? do
        it { is_expected.to permit(nil, event_context) }
      end
    end

    context 'and user is logged in' do
      permissions :show? do
        it { is_expected.to permit(user, event_context) }
      end
    end
  end

  context 'event has pincode' do
    let(:event) { Event.new(pincode: 'asd', user: user) }

    context 'and user is event owner' do
      let(:event_context) { EventContext.new(event: event, pincode: nil) }

      permissions :show? do
        it { is_expected.to permit(user, event_context) }
      end
    end

    context 'and user is not event owner' do
      let(:another_user) { User.new }
      let(:event_context) { EventContext.new(event: event, pincode: nil) }

      permissions :show? do
        it { is_expected.not_to permit(another_user, event_context) }
      end
    end

    context 'and user is not logged in' do
      let(:event_context) { EventContext.new(event: event, pincode: nil) }

      permissions :show? do
        it { is_expected.not_to permit(nil, event_context) }
      end
    end

    context 'and user has valid pincode' do
      let(:event_context) { EventContext.new(event: event, pincode: 'asd') }

      context 'and user is logged in' do
        permissions :show? do
          it { is_expected.to permit(nil, event_context) }
        end
      end

      context 'and user is not logged in' do
        let(:another_user) { User.new }

        permissions :show? do
          it { is_expected.to permit(another_user, event_context) }
        end
      end
    end
  end
end
