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
end
