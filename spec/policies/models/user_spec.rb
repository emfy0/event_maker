require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#find_for_vk_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'vkontakte',
        info: double(email: '123@gmail.com', name: 'UserName'),
        extra: double(raw_info: double(id: '123321'))
      )
    end

    context 'when user is not found' do
      let(:user) { User.find_for_vk_oauth(access_token) }
      it 'returns newly created user' do
        expect(user).to be_persisted
        expect(user.name).to eq 'UserName'
        expect(user.email).to eq '123@gmail.com'
      end
    end

    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: '123@gmail.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_vk_oauth(access_token)).to eq existing_user
      end
    end

    context 'when user is found by provider + provider_id' do
      let!(:existing_user) do
        create(:user, provider: 'vkontakte',
                      provider_id: '123321')
      end
      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_vk_oauth(access_token)).to eq existing_user
      end
    end
  end

  describe '#find_for_yandex_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'yandex',
        info: double(email: '123@gmail.com', name: 'UserName'),
        extra: double(raw_info: double(id: '123321'))
      )
    end

    context 'when user is not found' do
      let(:user) { User.find_for_yandex_oauth(access_token) }
      it 'returns newly created user' do
        expect(user).to be_persisted
        expect(user.name).to eq 'UserName'
        expect(user.email).to eq '123@gmail.com'
      end
    end

    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: '123@gmail.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_yandex_oauth(access_token)).to eq existing_user
      end
    end

    context 'when user is found by provider + provider_id' do
      let!(:existing_user) do
        create(:user, provider: 'yandex',
                      provider_id: '123321')
      end
      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_yandex_oauth(access_token)).to eq existing_user
      end
    end
  end
end
