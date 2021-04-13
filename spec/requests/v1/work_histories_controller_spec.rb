# frozen_string_literal: true
require 'rails_helper'

RSpec.describe V1::WorkHistoriesController, type: :request do
  # Account 1人目
  let(:work_histories) { build_list(:work_history, 5) }
  let!(:account_self) { create(:account, work_histories: work_histories)}
  let(:headers_self) { { Authorization: "Bearer #{account_self.jwt}" } }
  # Account 2人目
  let!(:account_other) { create(:account) }
  let(:headers_other) { { Authorization: "Bearer #{account_other.jwt}" } }
  # 職種、業種
  let(:occupation) { create(:occupation) }
  let(:industry) { create(:industry) }

  describe 'GET /v1/accounts/:account_id/work_histories' do
    subject(:request) { get v1_account_work_histories_path(account_self.id), headers: auth_header }

    context '自身の職歴の場合' do
      let(:auth_header) { headers_self }

      it '職歴一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['work_histories'].length).to eq account_self.work_histories.count
        expect(response_json['work_histories'][0]['id']).to eq account_self.work_histories.first.id
      end
    end

    context '他ユーザーの職歴の場合' do
      let(:auth_header) { headers_other }

      it '職歴一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['work_histories'].length).to eq account_self.work_histories.count
        expect(response_json['work_histories'][0]['id']).to eq account_self.work_histories.first.id
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '職歴一覧が取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['work_histories']).to be_nil
      end
    end
  end

  describe 'POST /v1/accounts/:account_id/work_histories' do
    subject(:request) { post v1_account_work_histories_path((account_self.id)), headers: auth_header, params: params }
    let(:params) do
      { work_history: attributes_for(:work_history).merge(occupation_id: occupation.id, industry_id: industry.id) }
    end

    context '自身の職歴の場合' do
      let(:auth_header) { headers_self }

      it '職歴が作成できること' do
        expect { request }.to change { WorkHistory.count }.by(+1)
        expect(response).to have_http_status(:created)
      end
    end

    context '他ユーザーの職歴の場合' do
      let(:auth_header) { headers_other }

      it '職歴が作成できないこと' do
        expect { request }.not_to change { WorkHistory.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '職歴が作成できないこと' do
        expect { request }.not_to change { WorkHistory.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /work_histories/{id}' do
    subject(:request) { get v1_work_history_path(work_histories.first.id), headers: auth_header }

    context '自身の職歴の場合' do
      let(:auth_header) { headers_self }

      it '職歴が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq account_self.work_histories.first.id
      end
    end

    context '他ユーザーの職歴の場合' do
      let(:auth_header) { headers_other }

      it '職歴が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq account_self.work_histories.first.id
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '職歴が取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end
  end

  describe 'PATCH /work_histories/{id}' do
    subject(:request) { patch v1_work_history_path((work_histories.first.id)), headers: auth_header, params: params }
    let(:params) do
      { work_history: attributes_for(:work_history, :is_employed_false, :has_until_date) }
    end

    context '自身の職歴の場合' do
      let(:auth_header) { headers_self }

      it '職歴が更新できること' do
        expect { request }.to change { work_histories.first.reload.is_employed }.from(true).to(false)
        expect(response).to have_http_status(:ok)
      end
    end

    context '他ユーザーの職歴の場合' do
      let(:auth_header) { headers_other }

      it '職歴が更新できないこと' do
        expect { request }.not_to change { work_histories.first.reload.is_employed }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '職歴が更新できないこと' do
        expect { request }.not_to change { work_histories.first.reload.is_employed }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /work_histories/{id}' do
    subject(:request) { delete v1_work_history_path((work_histories.first.id)), headers: auth_header }

    context '自身の職歴の場合' do
      let(:auth_header) { headers_self }

      it '職歴が削除できること' do
        expect { request }.to change { WorkHistory.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context '他ユーザーの職歴の場合' do
      let(:auth_header) { headers_other }

      it '職歴が削除できないこと' do
        expect { request }.not_to change { WorkHistory.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '職歴が削除できないこと' do
        expect { request }.not_to change { WorkHistory.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
