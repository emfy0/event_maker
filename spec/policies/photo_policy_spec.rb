require 'rails_helper'

RSpec.describe PhotoPolicy do
  let(:user) { User.new }

  subject { PhotoPolicy }

  context 'user in not authorized' do
    let(:photo) { Photo.new }

    permissions :create? do
      it { is_expected.not_to permit(nil, Photo) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(nil, photo) }
    end
  end

  context 'user is event owner' do
    let(:event) { Event.new(user: user) }
    let(:photo) { Photo.new(event: event) }

    permissions :create?, :destroy? do
      it { is_expected.to permit(user, photo) }
    end
  end

  context 'user is photo owner' do
    let(:photo) { Photo.new(user: user) }

    permissions :create? do
      it { is_expected.to permit(user, Photo) }
    end

    permissions :destroy? do
      it { is_expected.to permit(user, photo) }
    end
  end

  context 'user is not a photo owner' do
    let(:photo) { Photo.new }

    permissions :create? do
      it { is_expected.to permit(user, Photo) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(user, photo) }
    end
  end
end
