FactoryBot.define do
  factory :work_history do
    is_employed { true }
    position { "主任" }
    annual_income { 4000000 }
    management_experience { 3 }
    job_summary { "Ruby on Railsを使ったバックエンド開発" }
    since_date { "2019-08-01" }
    until_date { nil }
    sequence(:name) { |n| "社名_#{n}" }
    association :occupation
    association :industry

    trait :is_employed_false do
      is_employed { false }
    end

    trait :has_until_date do
      until_date { "2020-05-01" }
    end
  end
end
