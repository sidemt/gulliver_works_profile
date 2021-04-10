# frozen_string_literal: true
# Occupation
class Occupation < ApplicationRecord
  belongs_to :occupation_sub_category
  has_many :work_histories, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
