# frozen_string_literal: true
module Enterprise
  module V1
    # EmployeeSerializer
    class EmployeeProfileSerializer < ActiveModel::Serializer
      attributes :id,
                 :first_name,
                 :last_name,
                 :first_name_kana,
                 :last_name_kana,
                 :gender,
                 :phone,
                 :postal_code,
                 :address,
                 :date_of_birth,
                 :biography
    end
  end
end
