# frozen_string_literal: true
module V1
  class AcademicHistorySerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :faculty,
               :since_date,
               :until_date,
               :type
  end
end
