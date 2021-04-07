class Profile < ApplicationRecord
  enum gender: { male: 0, female: 1, other: 2 }
  attribute :gender, :integer, default: 2

  validates :first_name,
            :last_name,
            :first_name_kana,
            :last_name_kana,
            :gender,
            :phone,
            :date_of_birth, presence: true
end
