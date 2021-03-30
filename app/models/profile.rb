class Profile < ApplicationRecord

  enum gender: { MALE: 0, FEMALE: 1, OTHER: 2 }

  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :gender,
            :phone,
            :postal_code,
            :address,
            :date_of_birth,
            :biography, presence: true
end
