# frozen_string_literal: true
module Enterprise
  module V1
    class EmployeeProfilesController < EnterpriseController
      before_action :load_and_authorize_employee_profile, only: %i[show update]

      def show
        render json: @employee_profile
      end

      def create
        employee = Employee.find(params[:employee_id])
        @employee_profile = employee.build_employee_profile(employee_profile_params)
        authorize! :manage, @employee_profile

        @employee_profile.save!
        render json: @employee_profile, status: :created
      end

      def update
        @employee_profile.update!(employee_profile_params)
        render json: @employee_profile
      end

      private

      def load_and_authorize_employee_profile
        @employee_profile = Employee.find(params[:employee_id]).employee_profile
        authorize! :manage, @employee_profile
      end

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
