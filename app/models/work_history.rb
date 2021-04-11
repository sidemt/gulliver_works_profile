class WorkHistory < ApplicationRecord
  belongs_to :account
  belongs_to :occupation
  belongs_to :industry

  validates :position,
            :annual_income,
            :management_experience,
            :since_date,
            :name, presence: true
  validates :until_date, presence: true, if: -> { is_employed == false }
  validates :is_employed, inclusion: [true, false]
  validates :annual_income,
            :management_experience, numericality: { only_integer: true }
end
