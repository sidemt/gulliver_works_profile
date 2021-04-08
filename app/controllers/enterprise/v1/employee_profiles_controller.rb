# frozen_string_literal: true
module Enterprise
  module V1
    class EmployeeProfilesController < EnterpriseController
      load_and_authorize_resource :employee
      load_and_authorize_resource singleton: true, through: :employee

      def show
        render json: @employee_profile
      end

      def create
        @employee_profile.save!
        render json: @employee_profile, status: :created
      end

      def update
        @employee_profile.update!(employee_profile_params)
        render json: @employee_profile
      end

      private

      def employee_profile_params
        params.require(:profile).permit(:first_name,
                                        :last_name,
                                        :first_name_kana,
                                        :last_name_kana,
                                        :gender,
                                        :phone,
                                        :postal_code,
                                        :address,
                                        :date_of_birth,
                                        :biography)
      end
    end
  end
end
