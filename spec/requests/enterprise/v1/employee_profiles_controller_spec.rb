require 'rails_helper'

RSpec.describe Enterprise::V1::EmployeeProfilesController, type: :request do
  # Employee without Profile
  let!(:employee_a) { create(:employee) }
  let(:headers_a) { { Authorization: "Bearer #{employee_a.jwt}" } }
  # Employee with Profile
  let(:employee_profile) { build(:employee_profile) }
  let!(:employee_b) { create(:employee, employee_profile: employee_profile)}
  let(:headers_b) { { Authorization: "Bearer #{employee_b.jwt}" } }

  describe 'GET /employees/:employee_id/profile' do
    subject(:request) { get enterprise_v1_employee_profile_path(employee_b.id), headers: auth_header }

    context '自身のプロフィールの場合' do
      let(:auth_header) { headers_b }

      it '従業員のプロフィールが取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq employee_b.employee_profile.id
      end
    end

    context '他ユーザーのプロフィールの場合' do
      let(:auth_header) { headers_a }

      it '従業員のプロフィールが取得できること' do
        request
        expect(response).to have_http_status(:ok)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to eq employee_b.employee_profile.id
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '従業員のプロフィールが取得できないこと' do
        request
        expect(response).to have_http_status(:unauthorized)
        response_json = JSON.parse(response.body)
        expect(response_json['id']).to be_nil
      end
    end
  end

  describe 'POST /employees/:employee_id/profile' do
    subject(:request) { post enterprise_v1_employee_profile_path((employee_a.id)), headers: auth_header, params: params }
    let(:params) do
      { profile: attributes_for(:employee_profile) }
    end

    context '自身のプロフィールの場合' do
      let(:auth_header) { headers_a }

      it '従業員のプロフィールが作成できること' do
        expect { request }.to change { EmployeeProfile.count }.by(+1)
        expect(response).to have_http_status(:created)
      end
    end

    context '他ユーザーのプロフィールの場合' do
      let(:auth_header) { headers_b }

      it '従業員のプロフィールが作成できないこと' do
        expect { request }.not_to change { EmployeeProfile.count }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '従業員のプロフィールが作成できないこと' do
        expect { request }.not_to change { EmployeeProfile.count }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH /employees/:employee_id/profile' do
    subject(:request) { patch enterprise_v1_employee_profile_path((employee_b.id)), headers: auth_header, params: params }
    let(:params) do
      { profile: attributes_for(:employee_profile, :first_name_hanako) }
    end

    context '自身のプロフィールの場合' do
      let(:auth_header) { headers_b }

      it '従業員のプロフィールが更新できること' do
        expect { request }.to change { employee_b.employee_profile.reload.first_name }.from("太郎").to("花子")
        expect(response).to have_http_status(:ok)
      end
    end

    context '他ユーザーのプロフィールの場合' do
      let(:auth_header) { headers_a }

      it '従業員のプロフィールが更新できないこと' do
        expect { request }.not_to change { employee_b.employee_profile.reload.first_name }
        expect(response).to have_http_status(:forbidden)
      end
    end

    context '未ログインの場合' do
      let(:auth_header) { nil }

      it '従業員のプロフィールが更新できないこと' do
        expect { request }.not_to change { employee_b.employee_profile.reload.first_name }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
