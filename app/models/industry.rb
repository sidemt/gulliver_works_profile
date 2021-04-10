# frozen_string_literal: true
# Industry
class Industry < ApplicationRecord
  belongs_to :industry_category
  has_many :work_histories, dependent: :nullify

  validates :name, presence: true
  validates :industry_category_id, uniqueness: { scope: :name }
end
