# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::AccountProfilesController, type: :request do
  # Account without Profile
  let!(:account_a) { create(:account) }
  let(:headers_a) { { Authorization: "Bearer #{account_a.jwt}" } }
  # Account with Profile
  let(:account_profile) { build(:account_profile) }
  let!(:account_b) { create(:account, account_profile: account_profile)}
  let(:headers_b) { { Authorization: "Bearer #{account_b.jwt}" } }

  describe 'GET /v1/accounts/:account_id/profile' do
    subject(:request) { get v1_account_profile_path(account_b.id), headers: headers_b }

    it 'ユーザーのプロフィールが取得できること' do
      request
      expect(response).to have_http_status(:ok)
      response_json = JSON.parse(response.body)
      expect(response_json['id']).to eq account_b.account_profile.id
    end
  end

  describe 'POST /v1/accounts/:account_id/profile' do
    subject(:request) { post v1_account_profile_path((account_a.id)), headers: headers_a, params: params }
    let(:params) do
      { profile: attributes_for(:account_profile) }
    end

    it 'ユーザーのプロフィールが作成できること' do
      expect { request }.to change { AccountProfile.count }.by(+1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /v1/accounts/:account_id/profile' do
    subject(:request) { patch v1_account_profile_path((account_b.id)), headers: headers_b, params: params }
    let(:params) do
      { profile: attributes_for(:account_profile, :first_name_hanako) }
    end

    it 'ユーザーのプロフィールが更新できること' do
      expect { request }.to change { account_b.account_profile.reload.first_name }.from("太郎").to("花子")
      expect(response).to have_http_status(:ok)
    end
  end
end
