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
    subject(:request) { get enterprise_v1_employee_profile_path(employee_b.id), headers: headers_b }

    it '従業員のプロフィールが取得できること' do
      request
      expect(response).to have_http_status(:ok)
      response_json = JSON.parse(response.body)
      expect(response_json['id']).to eq employee_b.employee_profile.id
    end
  end

  describe 'POST /employees/:employee_id/profile' do
    subject(:request) { post enterprise_v1_employee_profile_path((employee_a.id)), headers: headers_a, params: params }
    let(:params) do
      { profile: {
        first_name: employee_profile.first_name,
        last_name: employee_profile.last_name,
        first_name_kana: employee_profile.first_name_kana,
        last_name_kana: employee_profile.last_name_kana,
        gender: employee_profile.gender,
        phone: employee_profile.phone,
        postal_code: employee_profile.postal_code,
        address: employee_profile.address,
        date_of_birth: employee_profile.date_of_birth,
        biography: employee_profile.biography
       } }
    end

    it '従業員のプロフィールが作成できること' do
      expect { request }.to change { EmployeeProfile.count }.by(+1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /employees/:employee_id/profile' do
    subject(:request) { patch enterprise_v1_employee_profile_path((employee_b.id)), headers: headers_b, params: params }
    let(:employee_profile_b) { build(:employee_profile_b) }
    let(:params) do
      { profile: {
        first_name: employee_profile_b.first_name,
        last_name: employee_profile_b.last_name,
        first_name_kana: employee_profile_b.first_name_kana,
        last_name_kana: employee_profile_b.last_name_kana,
        gender: employee_profile_b.gender,
        phone: employee_profile_b.phone,
        postal_code: employee_profile_b.postal_code,
        address: employee_profile_b.address,
        date_of_birth: employee_profile_b.date_of_birth,
        biography: employee_profile_b.biography
       } }
    end

    it '従業員のプロフィールが更新できること' do
      expect { request }.to change { employee_b.employee_profile.reload.first_name }.from("太郎").to("花子")
      expect(response).to have_http_status(:ok)
    end
  end
end
