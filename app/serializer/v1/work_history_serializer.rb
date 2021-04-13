# frozen_string_literal: true
module V1
  class WorkHistorySerializer < ActiveModel::Serializer
    attributes :id,
               :is_employed,
               :position,
               :annual_income,
               :management_experience,
               :job_summary,
               :since_date,
               :until_date,
               :name
    belongs_to :occupation
    belongs_to :industry
  end
end
