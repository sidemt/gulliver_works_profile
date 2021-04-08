# frozen_string_literal: true
module V1
  class AccountProfileSerializer < ActiveModel::Serializer
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
