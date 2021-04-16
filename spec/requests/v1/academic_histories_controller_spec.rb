# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AcademicHistoriesController, type: :request do
  # Account 1人目
  let(:academic_histories) { build_list(:academic_history, 3) }
  let!(:account_self) { create(:account, academic_histories: academic_histories)}
  let(:headers_self) { { Authorization: "Bearer #{account_self.jwt}" } }
  # Account 2人目
  let!(:account_other) { create(:account) }
  let(:headers_other) { { Authorization: "Bearer #{account_other.jwt}" } }

  describe 'GET /v1/accounts/:account_id/academic_histories' do
    subject(:request) { get v1_account_academic_histories_path(account_self.id), headers: auth_header }

    context '自身の学歴の場合' do
      let(:auth_header) { headers_self }

      it '学歴一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['academic_histories'].length).to eq account_self.academic_histories.count
        expect(response_json['academic_histories'][0]['id']).to eq account_self.academic_histories.first.id
      end
    end

    context '他ユーザーの学歴の場合' do
      let(:auth_header) { headers_other }

      it '学歴一覧が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['academic_histories'].length).to eq account_self.academic_histories.count
        expect(response_json['academic_histories'][0]['id']).to eq account_self.academic_histories.first.id
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '学歴一覧が取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['academic_histories']).to be_nil
      end
    end
  end

  describe 'POST /v1/accounts/:account_id/academic_histories' do
    subject(:request) { post v1_account_academic_histories_path((account_self.id)),
                             headers: auth_header,
                             params: params }
    let(:params) do
      { academic_history: attributes_for(:academic_history) }
    end

    context '自身の学歴の場合' do
      let(:auth_header) { headers_self }

      it '学歴が作成できること' do
        expect { request }.to change { AcademicHistory.count }.by(+1)
        expect(response).to have_http_status(:created)
      end
    end

    context '他ユーザーの学歴の場合' do
      let(:auth_header) { headers_other }

      it '学歴が作成できないこと' do
        expect { request }.not_to change { AcademicHistory.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '学歴が作成できないこと' do
        expect { request }.not_to change { AcademicHistory.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /academic_histories/{id}' do
    subject(:request) { get v1_academic_history_path(academic_histories.first.id), headers: auth_header }

    context '自身の学歴の場合' do
      let(:auth_header) { headers_self }

      it '学歴が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq account_self.academic_histories.first.id
      end
    end

    context '他ユーザーの学歴の場合' do
      let(:auth_header) { headers_other }

      it '学歴が取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq account_self.academic_histories.first.id
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '学歴が取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end
  end

  describe 'PATCH /academic_histories/{id}' do
    subject(:request) { patch v1_academic_history_path((academic_histories.first.id)), headers: auth_header, params: params }
    let(:params) do
      { academic_history: attributes_for(:academic_history, :type_high_school) }
    end

    context '自身の学歴の場合' do
      let(:auth_header) { headers_self }

      it '学歴が更新できること' do
        expect { request }.to change { academic_histories.first.reload.type }.from("university").to("high_school")
        expect(response).to have_http_status(:ok)
      end
    end

    context '他ユーザーの学歴の場合' do
      let(:auth_header) { headers_other }

      it '学歴が更新できないこと' do
        expect { request }.not_to change { academic_histories.first.reload.type }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '学歴が更新できないこと' do
        expect { request }.not_to change { academic_histories.first.reload.type }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /academic_histories/{id}' do
    subject(:request) { delete v1_academic_history_path((academic_histories.first.id)), headers: auth_header }

    context '自身の学歴の場合' do
      let(:auth_header) { headers_self }

      it '学歴が削除できること' do
        expect { request }.to change { AcademicHistory.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context '他ユーザーの学歴の場合' do
      let(:auth_header) { headers_other }

      it '学歴が削除できないこと' do
        expect { request }.not_to change { AcademicHistory.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '学歴が削除できないこと' do
        expect { request }.not_to change { AcademicHistory.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
