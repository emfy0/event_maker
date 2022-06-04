require 'rails_helper'

RSpec.describe CommentPolicy do
  let(:user) { User.new }

  subject { CommentPolicy }

  context 'user in not authorized' do
    let(:comment) { Comment.new }

    permissions :create? do
      it { is_expected.to permit(nil, Comment) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(nil, comment) }
    end
  end

  context 'user is event owner' do
    let(:event) { Event.new(user: user) }
    let(:comment) { Comment.new(event: event) }

    permissions :create?, :destroy? do
      it { is_expected.to permit(user, comment) }
    end
  end

  context 'user is comment owner' do
    let(:comment) { Comment.new(user: user) }

    permissions :create? do
      it { is_expected.to permit(user, Comment) }
    end

    permissions :destroy? do
      it { is_expected.to permit(user, comment) }
    end
  end

  context 'user is not a comment owner' do
    let(:comment) { Comment.new }

    permissions :create? do
      it { is_expected.to permit(user, Comment) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(user, comment) }
    end
  end
end
